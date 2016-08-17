// ActionScript file
package tools.player
{
	public class JitterBuffer
	{
		// 服务器配置参数
		protected var _forwardExtraTime:Number = 0.9;		// 快进附加时间
		protected var _enableForward:Boolean = false;		// 是否打开快进
		protected var _bufferMinJitter:Number = 900;		// 最小缓冲时间， 单位豪秒
		protected var _bufferMaxJitter:Number = 3000;			// 最大缓冲时间， 单位豪秒
		
		// 缓冲时间 
		protected var _bufferTime:Number = 30;				// 环形缓冲时间大小， 单位秒。页面亦可传递该值。
		protected var _fps:int = 10;						// 采样幀率
		protected var _ringBufferLen:int = 300;				// 环形缓冲时间大小， 单位帧
		
		// bufferTime环形缓冲
		private var _lastBufferTime:Number = 0;				// 上次buffertime
		private var _lastSystemTime:Number = 0;				// 上次的系统时间，单位：毫秒
		private var _MaxBufferTime:Number = 0;				// 统计最近一段时间最大的buffertime
		private var _MinBufferTime:Number = 999999;			// 统计最近一段时间最大的buffertime
		private var _ringBufferTime:Array;					// 最近一段时间的bufferTime缓冲序列列表
		private var _lastPlayTime:Number = -1;				// 最后一次更新_ringBufferTime时bytesLoaded
		private var _stopTime:Number = -1;					// 最后一次画面播放的时间点
		
		// Jitter Buffer 精度100毫秒
		private var _ringBufferJitter:Array;				// 最近一段时间的语音数据的 jitter列表
		private var _maxJitter:Number = 0;					// 最大的jitter
		private var _secondJitter:Number = 0;				// 第二大的jitter
		private var _lastAudioFrameTime:Number = 0;			// 上个 语音帧到达时间
		
		public function JitterBuffer(buftime:Number, enableforward:Boolean, forwardextratime:Number, minjitter:Number, maxjitter:Number)
		{
			_bufferTime = buftime;
			_forwardExtraTime = forwardextratime;
			_enableForward = enableforward;
			_bufferMinJitter = minjitter;
			_bufferMaxJitter = maxjitter;
			
			// 重新计算数值
			_ringBufferLen = _bufferTime * _fps
			_ringBufferTime = new Array();
			// jitter
			_ringBufferJitter = new Array();
		}
		
		public function clear():void {
			_MaxBufferTime = 0;
			_MinBufferTime = 999999;
			_ringBufferTime = new Array();
			
			_lastBufferTime = 0;
			_lastSystemTime = 0;
			_lastPlayTime = -1;
			
			_ringBufferJitter = new Array();
			_maxJitter = 0;
			_secondJitter = 0;
		}
		
		public function resetBySeek():void {
			_MaxBufferTime = 0;
			_MinBufferTime = 999999;
			_ringBufferTime = new Array();
			
			_lastBufferTime = 0;
			_lastSystemTime = 0;
			_lastPlayTime = -1;
		}
		
		public function set fps(fps:int):void {
			_fps = fps;
		}
		
		public function get fps():int {
			return _fps;
		}
		
		
		/**
		 * 
		 * @param currentbuffertime : ns.bufferLength
		 * @param playTime : ns.time
		 * @param lastAudioTime
		 * 
		 */		
		public function updateBufferTime(currentbuffertime:Number, playTime:Number, lastAudioTime:Number):void {
			var now:Date = new Date();
			var currentsystemtime:Number = now.getTime();
			var systemtimedelta:Number = currentsystemtime - _lastSystemTime;//
			//var buffertimedelta:Number = curretbuffertime - _lastBufferTime;
			var bufferTime:Number = 0;
			if(_lastPlayTime >= 0 && playTime == _lastPlayTime) {
				bufferTime =  currentbuffertime - (currentsystemtime - _stopTime) / 1000;
			}
			else {
				bufferTime = currentbuffertime;
				_stopTime = currentsystemtime;
			}
			pushBufferTime(bufferTime);
			_lastSystemTime = currentsystemtime;
			_lastBufferTime = currentbuffertime;
			_lastPlayTime = playTime;
			//trace(this._MaxBufferTime + " " + this._MinBufferTime + " " + (this._MaxBufferTime - this._MinBufferTime));
			
			// 更新抖动值，精确到100毫秒级别
			if (_lastAudioFrameTime != lastAudioTime)
			{
				pushBufferJitter(lastAudioTime - _lastAudioFrameTime);
				_lastAudioFrameTime = lastAudioTime;
			}
			else
			{
				// 没有音频包，补0
				pushBufferJitter(0);
			}
		}
		
		private function pushBufferJitter(jitter:Number):void {
			if (_ringBufferJitter.length >= _ringBufferLen) {
				popBufferJitter();
			}
			_ringBufferJitter.push(jitter)
			if (_maxJitter <= jitter) {
				_secondJitter = _maxJitter;
				_maxJitter = jitter;
			}
		}
		
		private function popBufferJitter():void {
			if (_ringBufferJitter.length >= _ringBufferLen) {
				var lastBufferJitter:Number = _ringBufferJitter.shift();
				if (_maxJitter == lastBufferJitter) {
					_maxJitter = _secondJitter;
					_secondJitter = findSecondJitter();
				} else if (_secondJitter == lastBufferJitter) {
					_secondJitter = findSecondJitter();
				}
			}
		}
		
		private function findSecondJitter():Number {
			if (_ringBufferJitter.length <= 0) {
				return 0;
			}
			var maxJitter:Number = _ringBufferJitter[0];
			var secondJitter:Number = 0;
			for(var i:int = 1; i < _ringBufferJitter.length; i++)	{
				if(maxJitter < _ringBufferJitter[i]) {
					secondJitter = maxJitter;
					maxJitter = _ringBufferJitter[i];
				}
			}
			return secondJitter;
		}
		
		private function findMaxJitter():Number {
			if (_ringBufferJitter.length <= 0) {
				return 0;
			}
			var maxBufferJitter:Number = _ringBufferJitter[0];
			for(var i:int = 1; i < _ringBufferJitter.length; i++)	{
				if(maxBufferJitter < _ringBufferJitter[i]) {
					maxBufferJitter = _ringBufferJitter[i];
				}
			}
			return maxBufferJitter;
		}
		
		private function pushBufferTime(bufferTime:Number):void {
			if (_ringBufferTime.length >= _ringBufferLen) {
				popBufferTime();
			}
			_ringBufferTime.push(bufferTime);
			if (_MaxBufferTime < bufferTime) {
				_MaxBufferTime = bufferTime;
			}
			if (_MinBufferTime > bufferTime) {
				_MinBufferTime = bufferTime;
			}
		} 
		
		private function popBufferTime():void {
			if (_ringBufferTime.length >= _ringBufferLen) {
				var lastBufferTime:Number = _ringBufferTime.shift();
				if (_MaxBufferTime == lastBufferTime) {
					_MaxBufferTime = findMaxBufferTime();
				}
				if (_MinBufferTime == lastBufferTime) {
					_MinBufferTime = findMinBufferTime();
				}
			}
		}
		
		private function findMaxBufferTime():Number {
			if (_ringBufferTime.length <= 0) {
				return 0;
			}
			var maxBufferTime:Number = _ringBufferTime[0];
			for(var i:int = 1; i < _ringBufferTime.length; i++)	{
				if(maxBufferTime < _ringBufferTime[i]) {
					maxBufferTime = _ringBufferTime[i];
				}
			}
			if(maxBufferTime > 0) {
				return maxBufferTime;
			}
			else
			{
				return 0;
			}
		}
		
		private function findMinBufferTime():Number {
			if (_ringBufferTime.length <= 0) {
				return 0;
			}
			var minBufferTime:Number = _ringBufferTime[0];
			for(var i:int = 1; i < _ringBufferTime.length; i++)	{
				if(minBufferTime > _ringBufferTime[i]) {
					minBufferTime = _ringBufferTime[i];
				}
			}
			return minBufferTime;
		}
		
		// 获取快进后应该剩余的时间
		public function get remainAfterSeek():Number {
			if (!_enableForward)
			{
				return 999999;
			}
			return (_MaxBufferTime -_MinBufferTime + _forwardExtraTime);
		}
		
		public function get jitter():Number {
			if (_bufferMinJitter > _secondJitter)
			{
				return _bufferMinJitter / 1000;
			}
			if (_bufferMaxJitter < _secondJitter)
			{
				return _bufferMaxJitter / 1000;
			}
			return _secondJitter / 1000;
		}
		
		// getter and setter
		
		public function get forwardextratime():Number {
			return _forwardExtraTime;
		}
		
		public function set forwardextratime(value:Number):void {
			_forwardExtraTime = value;
		}
		
		public function get enableforward():Boolean {
			return _enableForward;
		}
		
		public function set enableforward(value:Boolean):void {
			_enableForward = value;
		}
		
		public function get buffertime():Number {
			return _bufferTime;
		}
		
		public function set buffertime(value:Number):void {
			_bufferTime = value;
		}
	}
}