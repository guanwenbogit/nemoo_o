package bobo.modules.video.player
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.NetStreamAppendBytesAction;
	import flash.net.URLRequest;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	/**
	 * FLV NetStream.
	 * @author xqliang
	 * 
	 * @see http://www.osflash.org/flv
	 * @see http://opensource.adobe.com/svn/opensource/osmf/tags/20100212/framework/OSMF/org/osmf/net/httpstreaming/flv
	 */
	public class FLVNetStream extends NetStream
	{
		protected var _data:ByteArray = new ByteArray();
		protected var _header:ByteArray = new ByteArray();
		protected var _meta:ByteArray = new ByteArray();
		protected var _tags:Array = [];
		protected var _bytesLoaded:uint = 0;
		protected var _parsedPosition:uint = 0;
		protected var _savedPosition:uint = 0;
		protected var _savedTagIndex:int = -1;
		protected var _lastSeekTagIndex:int = -1;
		protected var _lastSeekTimestamp:Number = 0;
		protected var _firstKeyframeIndex:int = -1;
		protected var _urlStream:URLStream;
		protected var _httpStatus:uint = 200;
		protected var _parsedHeader:Boolean = false;
		protected var _playStopTimer:Timer;
		protected var _remainAfterSeek:Number = 400; // ms
		protected var _lastAudioFrameTime:Number = 0;
		
		public function FLVNetStream(connection:NetConnection, peerID:String="connectToFMS") {
			super(connection, peerID);
		}
		
		protected function clear():void {
			if (_urlStream) {
				_data.clear();
				_header.clear();
				_parsedHeader = false;
				_meta.clear();
				_parsedPosition = 0;
				_savedPosition = 0;
				_savedTagIndex = -1;
				_lastSeekTagIndex = -1;
				_lastSeekTimestamp = 0;
				_tags = [];
				try {
					_urlStream.close();
				} catch (error:Error) {
					trace("Close URLStream ", error.message);
				}
				_urlStream = null;
				_bytesLoaded = 0;
				if (_playStopTimer) {
					_playStopTimer.reset();
				}
			}
		}
		
		override public function play(...parameters):void {
			super.play(null);
			
			clear();
			_urlStream = new URLStream();
			_urlStream.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_urlStream.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
			_urlStream.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			_urlStream.addEventListener(Event.OPEN, onOpen);
			_urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
			_urlStream.addEventListener(Event.COMPLETE, onComplete);
			_urlStream.load(new URLRequest(String(parameters[0])));
      trace("[FLVNetStream/play] : " + String(parameters[0]));
		}
		
		/**
		 * @param seconds: seek forward for `seconds`, if seconds < 0, seek to the end.
		 */
		override public function seek(seconds:Number):void {
			var i:int, canSeek:Boolean = false, remain:Number, tme:Number=_lastSeekTimestamp; // NOTE: 每次seek后，netStream.time重新从0开始计时
			
			if (seconds < 0) {// seek to the end
				tme += this.time * 1000;
				for (i = _tags.length - 1; i > _lastSeekTagIndex; i--) {
					// 找到最后一个关键帧
					if (_tags[i].frameType == 1) {
						remain = _tags[_tags.length - 1].timestamp - _tags[i].timestamp;
						if (_tags[i].timestamp > tme && remain > _remainAfterSeek && remain < _remainAfterSeek + 400) {// 保证seek后还有一定的数据可以播放，且快进后不能剩余太多数据
							canSeek = true;
							break;
						}
					}
				}
			} else {
				tme += seconds * 1000;
				for (i = _lastSeekTagIndex + 1; i < _tags.length; i++) {
					// 找到下一个关键帧
					if (_tags[i].frameType == 1) {
						remain = _tags[_tags.length - 1].timestamp - _tags[i].timestamp;
						if (_tags[i].timestamp > tme && remain > _remainAfterSeek) {// 保证seek后还有一定的数据可以播放
							canSeek = true;
							break;
						}
					}
				}
			}
			
			// 每次快进确保能快进0.5s以上
			if (canSeek && bufferLength - remain/1000 > 0.5) {
				_lastSeekTagIndex = i;
				_lastSeekTimestamp = _tags[i].timestamp;
				dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Seek", level:"status"}));
				super.seek(0);// # Value is arbitrary. This plus RESET_SEEK flushes the FIFO buffer.
				appendBytesAction(NetStreamAppendBytesAction.RESET_SEEK);
				appendBytes(getData(0, i));
			}
		}
		
		override public function close():void {
			clear();
			super.close();
		}
		
		/** Event Handler **/
		
		private function onIOError(event:IOErrorEvent):void {
			clear();
			trace("IO error has occured " + event.text);
			if (_httpStatus == 200) {
				dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Failed", level:"error", message: event.text, status: _httpStatus}));
			}
			else {
				dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.StreamNotFound", level:"error", message: event.text, status: _httpStatus})); 
			}
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void {
			clear();
			trace("Security error has occured " + event.text);
			dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Failed", level:"error", message: event.text, status: _httpStatus})); 
		}
		
		private function onStatus(event:HTTPStatusEvent):void {
			trace("http status", event.status);
			_httpStatus = event.status;
		}
		
		private function onOpen(event:Event):void {
			trace("URLStream on open");
			// 这里不能 dispatch Play.Start 事件，因为可能返回非200
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			var buffer:ByteArray = new ByteArray();
			try {
				event.target.readBytes(buffer);
			} catch (error:Error) { // Catch EOF issue.
				trace(error);
				return;
			}
			
			_bytesLoaded += buffer.length;
			
			// Write data
			_data.writeBytes(buffer);
			
			// Header
			if (!_parsedHeader) {
				if (!parseHeader()) return;
				dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Start", level:"status"}));
				appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN);
				appendBytes(_header);
				_savedPosition = _header.length;
			}
			
			// Parse tags
			while (parseTag()) {
			}
			
			appendBytes(getData(0));
			// Release memory
			resizeData();
		}
		
		private function onComplete(event:Event):void {
			trace('complete', event);
			appendBytes(getData(0));
			appendBytesAction(NetStreamAppendBytesAction.END_SEQUENCE);
			if (!_playStopTimer) {
				_playStopTimer = new Timer(500);
				_playStopTimer.addEventListener(TimerEvent.TIMER, onPlayStopTimer);
			}
			_playStopTimer.start();
		}
		
		private function onPlayStopTimer(event:TimerEvent):void {
			if (bufferLength < 0.01) {
				_playStopTimer.stop();
				dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Stop", level:"status"}));
			}
		}
		
		/** Util Function **/
		
		protected function getData(seconds:Number, startTagIndex:Number=-1):ByteArray {
			var buffer:ByteArray = new ByteArray();
			var start:int = startTagIndex < 0 ? (_savedTagIndex + 1) : startTagIndex;
			if (start >= _tags.length) return buffer;
			
			var end:int;
			if (seconds == 0) {
				// 当前位置返回所有
				end = _tags.length - 1;
			}
			else {
				var millisecond:Number = seconds * 1000;
				for (end = start; end < _tags.length - 1; end++) {
					if (_tags[end].timestamp - _tags[start].timestamp >= millisecond) {
						break;
					}
				}
			}
			
			if (_tags.length > 0 && end >= start) {
				var fromTag:Object = _tags[start];
				var toTag:Object = _tags[end];
				if (startTagIndex < 0) {
					buffer.writeBytes(_data, _savedPosition, toTag.position + toTag.length - fromTag.position);
				}
				else {
					buffer.writeBytes(_data, fromTag.position, toTag.position + toTag.length - fromTag.position);
				}
				_savedTagIndex = end;
				_savedPosition = toTag.position + toTag.length;
			}
			
			return buffer;
		}
		
		private function resizeData():void {
			if (_savedTagIndex > 0 && _tags.length > 1) {
				var timestamp:Number = _tags[_savedTagIndex].timestamp - 2 * bufferLength * 1000;
				for (var i:int = _savedTagIndex; i >= 0; i--) {
					if (_tags[i].timestamp < timestamp) {
						break;
					}
				}
				// 释放老数据
				if (i >= 0 && _tags[i].position > 4 * 1024 * 1024) {
					var position:Number = _tags[i].position + _tags[i].length;
					var newData:ByteArray = new ByteArray();
					newData.writeBytes(_data, position);
					_data = newData;
					// 重设相对位置
					_parsedPosition -= position;
					_tags = _tags.slice(i);
					_savedTagIndex -= i;
					_lastSeekTagIndex = Math.max(-1, _lastSeekTagIndex - i);
					for (var k:int = 0; k < _tags.length; k++) {
						_tags[k].position -= position;
					}
					_savedPosition -= position;
				}
			}
		}
		
		private function parseHeader():Boolean {
			// header (9 bytes) + previous tag size (4 bytes)
			var available:int = _data.length - _parsedPosition;
			if (available < 9 + 4)
				return false;
			
			trace("Parse header " + String(_data.length) + " bytes.");
			var hex:String = byte2hex(_data, _parsedPosition, 9);
			if (hex.substr(0, 8) != "464c5601" || !(hex.substr(8, 2) == "01" || hex.substr(8, 2) == "05") || hex.substr(10) != "00000009") {
				trace("Not a FLV video file!");
				return false;
			}
			_parsedPosition += 9 + 4;
			_header.writeBytes(_data, 0, _parsedPosition);
			_parsedHeader = true;
			return true;
		}
		
		private function parseTag():Boolean {
			// tag header (11 bytes) + tag body + previous tag size (4 bytes)
			var available:int = _data.length - _parsedPosition;
			if (available < 11 + 4)
				return false;
			
			var tagBuffer:ByteArray = new ByteArray();
			tagBuffer.writeBytes(_data, _parsedPosition, 11);
			
			var type:int = getTagType(tagBuffer);
			var length:int = getLength(tagBuffer);
			var timestamp:int = getTimestamp(tagBuffer);
			if (available < 11 + length + 4) {
				return false;
			}
			var tag:Object = {position: _parsedPosition, length: 11 + length + 4, type: type, timestamp: timestamp};
			if (type == 0x12) { // Meta
				_meta.clear();
				_meta.writeBytes(_data, tag.position, tag.length);
			}
			else if (type == 0x08 || type == 0x09) { // Audio & Video
				tagBuffer.writeBytes(_data, _parsedPosition + 11, 1);
				if (type == 0x09) {
					tag["frameType"] = getFrameType(tagBuffer);
					if (_firstKeyframeIndex == -1 && tag["frameType"] == 1) {
						_firstKeyframeIndex = _tags.length - 1;
					}
				}
				else
				{
					var now:Date = new Date();
					_lastAudioFrameTime = now.getTime();
				}
			}
			_parsedPosition += tag.length;
			_tags.push(tag);
			return true;
		}
		
		/**
		 * 音频/视频 
		 * @param bytes
		 * @return 
		 * 
		 */		
		static protected function getTagType(bytes:ByteArray):uint {
			return bytes[0];
		}
		
		static protected function getLength(bytes:ByteArray):uint {
			return (bytes[1] << 16) | (bytes[2] << 8) | (bytes[3]);
		}
		
		static protected function getTimestamp(bytes:ByteArray):uint {
			return (bytes[7] << 24) | (bytes[4] << 16) | (bytes[5] << 8) | (bytes[6]);
		}
		
		/**
		 * 关键帧 1 
		 * @param bytes
		 * @return 
		 * 
		 */		
		static protected function getFrameType(bytes:ByteArray):int {
			return (bytes[11] & 0xf0) >> 4;
		}
		
		static protected function byte2hex(bytes:ByteArray, offset:int, length:int):String {
			var text:String = "";
			for (var i:int = offset; i < offset + length; i++) {
				var hex:String = (bytes[i] as uint).toString(16);
				text += hex.length < 2 ? "0" + hex : hex;
			}
			return text;
		}
		
		/** Getter & Setter **/
		
		override public function get bytesLoaded():uint {
			return _bytesLoaded;
		}
		
		public function get delay():Number {
			if (_tags.length >= 2) {
				var start:Number = _savedTagIndex == -1 ? 0 : _tags[_savedTagIndex].timestamp;
				return (_tags[_tags.length - 1].timestamp - start) / 1000;
			}
			return 0;
		}
		
		public function get firstKeyframe():int {
			for (var i:int = 0; i < _tags.length - 1; i++) {
				if (_tags[i].frameType == 1) {
					break;
				}
			}
			return i != _tags.length ? i : -1;
		}
		
		public function get lastKeyframe():int {
			for (var i:int = _tags.length - 1; i >= 0; i--) {
				if (_tags[i].frameType == 1) {
					break;
				}
			}
			return i;
		}
		
		public function get lastAudioTime():Number {
			return _lastAudioFrameTime;
		}
		
		public function get header():ByteArray {
			return _header;
		}
		
		public function get meta():ByteArray {
			return _meta;
		}
		
		public function set remainAfterSeek(value:Number):void {
			_remainAfterSeek = value;
		}
	}
}