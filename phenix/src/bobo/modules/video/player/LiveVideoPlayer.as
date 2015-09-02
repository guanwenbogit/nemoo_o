package bobo.modules.video.player
{

	

	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.system.Security;
	import flash.utils.Timer;
	
	import mx.utils.StringUtil;
	
	import org.osflash.signals.Signal;
	
	/**
	 * @author sytang
	 *
	 */
	public class LiveVideoPlayer extends EventDispatcher
	{
		public static const WIDTH:int = 590;
		public static const HEIGHT:int = 420;
		private var _userNum:int = -1;
		
		private var reConnCounter:int = 0;
		private var reConnTimes:int = 20;
		
		private var _bufferPCT:Number = 0;
		
		private var hbTime:int = 0;//心跳发送时间点，秒。
		private var timer:Timer = new Timer(200);//播放状态
		
		private var checkStatus:Timer = new Timer(3000, 1);//缓冲
		//private var failedTimer:Timer = new Timer(1500, 1);
		//private var nsTime:Number = 0;
		
		private var downSp : Number = 0;  //统计用下载速度
		private var loadedbefore : int = 0;
		private var speedArr:Array = [];
		private var _bf:Boolean = false;
		private var _isLiving:Boolean = true;
		private var _roomID:int;
		private var reconnTimer:Timer = new Timer(2000);
		private var blTime:int = 0;//记录bufferlength的时间
		
		/**
		 * Construct a <code>LiveVideoPlayer</code>.
		 */
		public function LiveVideoPlayer(userNum:int,w:int,h:int)
		{	
			_userNum = userNum;
			_video = new Video(w, h);
			_video.smoothing = true;
			netConnection = new NetConnection();
			initListeners();
			Security.loadPolicyFile("http://extapi.live.netease.com/crossdomain.xml");
			//play(userNum);
			
			try
			{
				flash.external.ExternalInterface.addCallback("getBL", getBL);
			}
			catch(error:Error)
			{
//				Debug.console(error);
			}
		}
		
		//----------------------------------
		//  video
		//----------------------------------
		private var _video:Video;
		
		public function get video():Video
		{
			return _video;
		}
		//----------------------------------
		//  completeSignal
		//----------------------------------
		private var _completeSignal:Signal = new Signal();
		
		public function get completeSignal():Signal
		{
			return _completeSignal;
		}
		//==========================================================================
		//  Variables
		//==========================================================================
		private var isPlaying:Boolean = false;
		private var userNum:int;
		private var BUFFER_TIME:Number = 0.7;
		
		private var netConnection:NetConnection;
		private var netStream:NetStream;
		private var soundTransform:SoundTransform = new SoundTransform();
		
		private var _updateJitterTimer:Timer = null;
		private var _jitter:JitterBuffer = null;
		private var _lastSeekTime:Number = 0; //seek.notify时赋值
		
		private var t:Timer = new Timer(30000);//超时
		
		private var streamURL:String = '';
		
		//==========================================================================
		//  Public methods
		//==========================================================================
		public function play(userNum:int,url:String):void
		{
			if (isPlaying)
			{
				return;
			}
			this.userNum = userNum;
			if (userNum < 0)
			{
				return;
			}
			
			isPlaying = true;
			dispatchEvent(new Event("HIDE_RECONN"));
			if (netStream)netStream.close();
			streamURL = StringUtil.substitute(url, String(userNum));
			try
			{
				if (_jitter)
				{
					_jitter.clear();
					_updateJitterTimer.start();
				}
				
				netStream.play(streamURL);
				//if(!t.running)t.start();
				t.stop();
				t.start();
			}
			catch (e:Error)
			{
//				Debug.console(e);
			}
		}
    
    public function playCDN(url:String):void
    {
      if (isPlaying)
      {
        return;
      }
      isPlaying = true;
      dispatchEvent(new Event("HIDE_RECONN"));
      if (netStream) netStream.close();
      try
      {
        if (_jitter)
        {
          _jitter.clear();
          _updateJitterTimer.start();
        }
        
        netStream.play(url);
        //if(!t.running)t.start();
        t.stop();
        t.start();
      }
      catch (e:Error)
      {
//        Debug.console(e);
      }
    }
		
		private function connectStream():void
		{
			netStream = new FLVNetStream(netConnection);
			netStream.addEventListener(NetStatusEvent.NET_STATUS, streamStatusHandler);
			netStream.bufferTime = BUFFER_TIME;
			netStream.soundTransform = soundTransform;
			netStream.client = new CustomClient();
			_video.attachNetStream(netStream);
			
			timer.addEventListener(TimerEvent.TIMER, timerHandler);
			//play(FileURL.userNum);
			reconnTimer.addEventListener(TimerEvent.TIMER, reconnTimerHandler);
		}
		
		public function changeVol(value:Number):void
		{
			soundTransform.volume = value;
			if (netStream)
			{
				netStream.soundTransform = soundTransform;
			}
		}
		//用于在没有流时清除video的最后一帧画面
    public function clear() : void {
      _video.clear();
    }
    
		public function close():void
		{
			isPlaying = false;
			netStream.close();
			video.clear();
			if(timer.running)timer.stop();
			if(t.running)t.stop();
			if(checkStatus.running)checkStatus.stop();
			if(_updateJitterTimer.running)_updateJitterTimer.stop();
			if(reconnTimer.running)reconnTimer.stop();
		}
		
		/**
		 * 重连 
		 * StreamNotFound、超时
		 */		
		public function reConn():void
		{
			dispatchEvent(new Event("HIDE_RECONN"));
			
			reConnCounter++;
			if(reConnCounter < reConnTimes)
			{
//				Log.log("reConn");
				
				netStream.close();
				try
				{
					if (_jitter)
					{
						_jitter.clear();
						_updateJitterTimer.start();
					}
					
					var _url:String = streamURL + "?" + (new Date).time;
//					Log.log("streamURL="+_url);
					netStream.play(_url);
					
					t.stop();
					t.start();
				}
				catch (e:Error)
				{
//					Debug.console(e);
				}
			}
			else if(reConnCounter >= reConnTimes)
			{
//				Log.log("sth wrong");
				
				if(timer.running)timer.stop();
				if(t.running)t.stop();
				if(checkStatus.running)checkStatus.stop();
				if(_updateJitterTimer.running)_updateJitterTimer.stop();
				if(reconnTimer.running)reconnTimer.stop();
				netStream.close();
				_video.clear();
				
				dispatchEvent(new Event("REMOVE_COVER"));
				dispatchEvent(new Event("HIDE_BUFFERING"));
				dispatchEvent(new Event("SHOW_RECONN"));
			}
		}
		
		/**
		 * 延迟 重连 
		 * @param event
		 * 
		 */		
		private function reconnTimerHandler(event:TimerEvent):void
		{
			reconnTimer.stop();
			reConn();
		}
		
		public function get bufferPCT():Number
		{
			return _bufferPCT;
		}
		
		public function set reSetCnt(_r:int):void
		{
			reConnCounter = _r;
		}
		
		public function set isLiving(_r:Boolean):void
		{
			_isLiving = _r;
		}
		public function get isLiving():Boolean
		{
			return _isLiving;
		}
		
		public function set roomID(_id:int):void
		{
			_roomID = _id;
		}
		public function get roomID():int
		{
			return _roomID;
		}
		
		public function get bf():Boolean
		{
			return _bf;
		}
		
		//==========================================================================
		//  Private methods
		//==========================================================================
		private function initListeners():void
		{
			_jitter = new JitterBuffer(60, true, 2.0, 1000, 5000);
			_updateJitterTimer = new Timer(1000 / _jitter.fps);
			_updateJitterTimer.addEventListener(TimerEvent.TIMER, onUpdateJitter);
			
			netConnection.addEventListener(NetStatusEvent.NET_STATUS, netConnectionStatusHandler);
			netConnection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, netConnectionSecurityHandler);
			netConnection.connect(null);
			
			t.addEventListener(TimerEvent.TIMER, tHandler);
			
			checkStatus.addEventListener(TimerEvent.TIMER, checkStatusHandler);
			//failedTimer.addEventListener(TimerEvent.TIMER, failedTimerHandler);
		}
		
		private function getfileId():String
		{
			var _tempArr:Array = streamURL.split("?");
			var _tempArr1:Array = _tempArr[0].split("/");
			return _tempArr1[_tempArr1.length-1];
		}
		
		//==========================================================================
		//  Event handlers
		//==========================================================================
		private function netConnectionSecurityHandler(event:SecurityErrorEvent):void
		{
			trace("[VIDEO NETCONNECTION SECURITY ERROR]");
//			Tracer.add("[VIDEO NETCONNECTION SECURITY ERROR]");
		}
		
		private function netConnectionStatusHandler(event:NetStatusEvent):void
		{
			switch (event.info["code"])
			{
				case "NetConnection.Connect.Success":
					checkStatus.reset();
					connectStream();
					break;
				default:
					break;
			}
		}
		
		private function onUpdateJitter(event:TimerEvent):void
		{
			if (_jitter)
			{
				_jitter.updateBufferTime(this.netStream.bufferLength, this.netStream.time, FLVNetStream(netStream).lastAudioTime);
				var remainAfterSeek:Number = _jitter.remainAfterSeek;
				if (remainAfterSeek < netStream.bufferTime)
				{
					remainAfterSeek = netStream.bufferTime;
				}
				if (this.netStream.bufferLength > remainAfterSeek)
				{
					//离上次快进超过特定时间。两次快进需超过一定时间（30s or 60s）
					if (_lastSeekTime <= 0 || new Date().time - _lastSeekTime > _jitter.buffertime * 1000)
					{
						FLVNetStream(netStream).remainAfterSeek = remainAfterSeek * 1000;
						netStream.seek(-1);
					}
				}
			}
		}
		
		private function streamStatusHandler(event:NetStatusEvent):void
		{
//			Log.log("StreamNetStatus : " + event.info.code);
      trace("[LiveVideoPlayer/streamStatusHandler] ==========" + event.info.code);
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success": 
					break;
				case "NetStream.Play.StreamNotFound": 
					if (_jitter)
					{
						_updateJitterTimer.stop();
					}
					//reConn();
					reconnTimer.stop();
					reconnTimer.delay = Math.random() * 2000 + 1000;
					reconnTimer.start();
					break;
				case 'NetStream.Seek.Notify': 
					_lastSeekTime = new Date().time;
					if (_jitter)
					{
						_jitter.resetBySeek();
					}
					break;
				case 'NetStream.Buffer.Empty': 
					//if (!t.running)t.start();
					checkStatus.reset();
					checkStatus.delay = Math.random() * 2000 + 1000;
					checkStatus.start();
					break;
				case "NetStream.Buffer.Full":
					if (t.running)t.stop();
					if(!_bf)
					{
						dispatchEvent(new Event("REMOVE_COVER"));
						StatAdapter.instance.videoSuccess(streamURL, getRoomID(), getfileId());
						_bf = true;
					}
					checkStatus.reset();
					dispatchEvent(new Event("HIDE_BUFFERING"));
					break;
				case "NetStream.Play.Start": 
					checkStatus.reset();
					if(!timer.running)timer.start();
					//t.stop();
					break;
				case "NetStream.Play.Stop": 
					checkStatus.reset();
					if(!t.running)t.start();
					//dispatchEvent(new Event("HIDE_BUFFERING"));
					dispatchEvent(new Event("REMOVE_COVER"));
					break;
				
			}
		}
		
		private function timerHandler(event:TimerEvent):void
		{
			var _hb:int = Math.floor(timer.currentCount*timer.delay/1000);
			
			//心跳
			if(_hb!=hbTime && _hb%60==0)
			{
				hbTime = _hb;
				var _s:int = 0;
				var _len:int = speedArr.length;
				for(var i:int=0; i<_len;i++)_s += speedArr[i];
				StatAdapter.instance.heartbeat(netStream.time.toString(), getRoomID(), getfileId(), (Math.floor(_s/_len*100)/100).toString());
				speedArr = [];
			}
			
			//加载速度
			downSp = (netStream.bytesLoaded - loadedbefore) / (timer.delay / 1000) / 1024;
			loadedbefore = netStream.bytesLoaded;
			if(downSp>0)speedArr.push(downSp);
			
			//缓冲百分比
			var _temp:Number = netStream.bufferLength/netStream.bufferTime;
			_bufferPCT = (_temp < 1)?_temp:1;
			
			//记录BufferLength
			var _bl:int = Math.floor(timer.currentCount*timer.delay/1000);
			if(blTime!=_bl && _bl%30==0)
			{
				blTime = _bl;
//				Log.log("BufferLength : "+netStream.bufferLength);
			}
		}
		
		/**
		 * 超时 
		 * @param event
		 * 
		 */		
		private function tHandler(event:TimerEvent):void
		{
//			Debug.console("超时");
			
			if(t.running)t.stop();
			if(timer.running)timer.stop();
			if(_updateJitterTimer.running)_updateJitterTimer.stop();
			if(checkStatus.running)checkStatus.stop();
			if(reconnTimer.running)reconnTimer.stop();
			netStream.close();
			
			/*
			var _t:Timer = new Timer((Math.floor(Math.random()*4)+1)*1000, 1);
			_t.addEventListener(TimerEvent.TIMER, function(e:TimerEvent):void{
				reConn();
			});
			_t.start();
			*/
			reConn();
		}
		
		/**
		 * 缓冲检测 
		 * @param event
		 * 
		 */		
		private function checkStatusHandler(event:TimerEvent):void
		{
			if(isLiving)
			{
				t.stop();
				t.start();
//				Debug.console('意外停播');
//				StatAdapter.instance.buffer(netStream.time.toString(), getRoomID(), getfileId());
				dispatchEvent(new Event("SHOW_BUFFERING"));
			}
			else
			{
//				Debug.console('主播停播');
				
				if(t.running)t.stop();
				if(timer.running)timer.stop();
				//if(timeout.running)timeout.stop();
				if(_updateJitterTimer.running)_updateJitterTimer.stop();
				if(checkStatus.running)checkStatus.stop();
				if(reconnTimer.running)reconnTimer.stop();
				netStream.close();
			}
		}
		
		private function getRoomID():String
		{
			var _roomID:String = "";
			var _tempArr:Array = [];
			
			if(roomID == 0)
			{
				var _url:String = "";
				try
				{
					_url = ExternalInterface.call("function(){return window.location.href}");
				}
				catch(error:Error)
				{
//					Debug.console(error.toString());
				}
				_tempArr = _url.split("/");
				//_roomID = _tempArr[_tempArr.length-1].toString().slice(0, 6);
				_roomID = _tempArr[_tempArr.length-1].toString().split("?")[0];
			}
			else
			{
				_roomID = roomID.toString();
			}
			
			return _roomID;
		}
		
		
		public function getBL():Number
		{
			if(netStream)
				return netStream.bufferLength;
			else
				return -1;
		}
		
	}
}

class CustomClient
{
	public function onMetaData(info:Object):void
	{
		trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	}
	
	public function onCuePoint(info:Object):void
	{
		trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
}