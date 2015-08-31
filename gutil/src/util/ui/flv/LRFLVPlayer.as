package util.ui.flv {
  import flash.net.URLRequest;
  import flash.net.NetStreamAppendBytesAction;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.utils.ByteArray;
  import flash.net.URLStream;


  import flash.text.TextField;
  import flash.events.TimerEvent;
  import flash.utils.Timer;


  import flash.events.SecurityErrorEvent;
  import flash.events.NetStatusEvent;
  import flash.net.NetConnection;
  import flash.net.NetStream;
  import flash.media.Video;
  import flash.display.Sprite;

  /**
   * @author wbguan
   */
  public class LRFLVPlayer extends Sprite {
    private var _video:Video;
    private var _netStream:NetStream;
    private var _netConnect:NetConnection;
    private var _w:int;
    private var _h:int;
    private var _duration:int = 0;
    private var _killer:Timer = new Timer(5000, 1);
    private var _playing:Boolean;
    private var _protectTimer:Timer = new Timer(2000, 1);
    private var _retry:Timer = new Timer(15000, 1);
    private var _txt:TextField = new TextField();
    private var _count:int = 0;
    private var _loader:URLStream;
    private var _loaderBuffer:ByteArray;
    private var _testLoader:Timer = new Timer(200);
    private var _playFunc:Function;

    public function LRFLVPlayer(w:int, h:int) {
      this._w = w;
      this._h = h;
      initInstance();
      _txt.text = "正在加载,如果网络较差将在一段时间后移除该动画...";
    }

    private function initInstance():void {
      this._video = new Video(this._w, this._h);
      this._netConnect = new NetConnection();
      this._loader = new URLStream();
      this._netConnect.addEventListener(NetStatusEvent.NET_STATUS, onNetConnect);
      this._netConnect.addEventListener(SecurityErrorEvent.SECURITY_ERROR, netConnectionSecurityHandler);
      this.addChild(this._video);
      this._killer.addEventListener(TimerEvent.TIMER_COMPLETE, onKiller);
      this._protectTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
      this._retry.addEventListener(TimerEvent.TIMER_COMPLETE, onRetry);
    }

    private function onRetry(event:TimerEvent):void {
      trace("[LRFLVPlayer/onRetry] count :" + _count);
      this._retry.stop();
      this._retry.reset();
      if (_count < 1) {
        if (this._netStream != null) {
          this._netStream.close();
          this._netStream.play(_url);
        }
        _count++ ;
      } else {
        this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
      }
    }

    private function onTimerComplete(event:TimerEvent):void {
      this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
    }

    private function onKiller(event:TimerEvent):void {
      this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
    }

    private function netConnectionSecurityHandler(event:SecurityErrorEvent):void {
      this.dispatchEvent(new LRFLVEvent(LRFLVEvent.ERROR));
    }

    private function onNetConnect(event:NetStatusEvent):void {
      switch (event.info["code"]) {
        case "NetConnection.Connect.Success":
          connectSuccess();
          break;
        default:
          this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
          trace("[LRFLVPlayer/onNetConnect] " + event.info["code"]);
          break;
      }
    }

    private function connectSuccess():void {
      this._netStream = new NetStream(this._netConnect);
      this._netStream.bufferTime = 1;
      this._netStream.client = this;
      this._video.attachNetStream(this._netStream);
      this._netStream.addEventListener(NetStatusEvent.NET_STATUS, onNetStreamStatus);
      if(_playFunc != null){
        _playFunc();
      }
    }

    private function onNetStreamStatus(event:NetStatusEvent):void {
      switch (event.info["code"]) {
        case "NetConnection.Connect.Success":
          break;
        case "NetStream.Play.StreamNotFound":
          this.dispatchEvent(new LRFLVEvent(LRFLVEvent.NOT_FOUND));
          break;
        case 'NetStream.Seek.Notify':
          break;
        case 'NetStream.Buffer.Empty':
          // this._killer.start();
          if (!this._retry.running) {
            this._retry.start();
          }
          break;
        case "NetStream.Buffer.Full":
          this._retry.stop();
          this._retry.reset();
          this._killer.stop();
          this._killer.reset();
          if (this.contains(this._txt)) {
            this.removeChild(this._txt);
          }
          break;
        case "NetStream.Play.Start":
          if (this.contains(this._txt)) {
            this.removeChild(this._txt);
          }
          this.dispatchEvent(new LRFLVEvent(LRFLVEvent.START));
          break;
        case "NetStream.Play.Stop":
          this._killer.stop();
          this._killer.reset();
          this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
          break;
        case "NetStream.Play.Failed":
          if (!this._retry.running) {
            this._retry.start();
          }
          break;
        default:
          // this.dispatchEvent(new LRFLVEvent(LRFLVEvent.STOP));
          break;
      }
    }

    private var _url:String = "";

    public function play(url:String):void {
      _url = url;
      if (this._netStream != null) {
        nsPlay();
      } else {
        this._playFunc = nsPlay;
      }
    }

    private function nsPlay():void {
      this._netStream.play(_url);
    }

    private var _reload:Boolean = false;

    public function loadAndPlay(url:String):void {
      _url = url;
      var req:URLRequest = new URLRequest(_url);
      _loader.addEventListener(Event.COMPLETE, onLoaded);
      _loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurity);
      _loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _loader.load(req);
    }

    private function reload():void {
      var req:URLRequest = new URLRequest(_url);
      _loader.load(req);
      trace("[LRFLVPlayer/reload]");
    }

    private function onIOError(event:IOErrorEvent):void {
      if (!_reload) {
        _reload = true;
        reload();
      } else {
        this.dispatchEvent(new LRFLVEvent(LRFLVEvent.ERROR));
      }
    }

    private function onSecurity(event:SecurityErrorEvent):void {
      if (!_reload) {
        _reload = true;
        this.play(_url);
      } else {
        this.dispatchEvent(new LRFLVEvent(LRFLVEvent.ERROR));
      }
    }

    private function onLoaded(event:Event):void {
      _loader.removeEventListener(Event.COMPLETE, onLoaded);
      _loaderBuffer = new ByteArray();
      _loader.readBytes(_loaderBuffer, 0, _loader.bytesAvailable);
      _loaderBuffer.position = 0;
      trace(_loaderBuffer.length);
      if (this._netStream != null) {
        trace("[LRFLVPlayer/onLoaded] =============");
        nsAppendPlay();
      } else {
        _playFunc = nsAppendPlay;
      }
    }

    private function nsAppendPlay():void {
      this._netStream.play(null);
      _testLoader.addEventListener(TimerEvent.TIMER, onTestTimer);
      _netStream.dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Start", level:"status"}));
      this._netStream.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN);
      this._netStream.appendBytes(_loaderBuffer);
      this._netStream.appendBytesAction(NetStreamAppendBytesAction.END_SEQUENCE);
      _testLoader.start();
    }

    private function onTestTimer(event:TimerEvent):void {
      if (this._netStream.bufferLength < 0.01) {
        _netStream.dispatchEvent(new NetStatusEvent(NetStatusEvent.NET_STATUS, false, false, {code:"NetStream.Play.Stop", level:"status"}));
        this._testLoader.stop();
        this._testLoader.reset();
        _testLoader.removeEventListener(TimerEvent.TIMER, onTestTimer);
      }
    }

    public function stop():void {
      if (this._netStream != null) {
        this._netStream.pause();
      }
    }

    public function dispose():void {
      this._netStream.client = {};
      this._netStream.removeEventListener(NetStatusEvent.NET_STATUS, onNetStreamStatus);
      this._netConnect.removeEventListener(NetStatusEvent.NET_STATUS, onNetConnect);
      this._killer.removeEventListener(TimerEvent.TIMER_COMPLETE, onKiller);
      this._retry.removeEventListener(TimerEvent.TIMER_COMPLETE, onRetry);
      this._retry.stop();
      this._killer.stop();
      this._netStream.close();
      this._netConnect.close();
      this._video.clear();
      this._protectTimer.stop();
      this._count = 0;
      this._playFunc = null;
    }

    public function connect(param:String = null, ...args):void {
      this._netConnect.connect(param, args);
    }

    public function onMetaData(info:Object):void {
      trace("[LRFLVPlayer/onMetaData] " + JSON.stringify(info));
      trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
      this._video.width = info.width;
      this._video.height = info.height;
      // this._video.scaleX = this._video.scaleY = 2.5;
      this.x = -int(this.width / 2);
      var h:int = 500;
      if (this.stage != null) {
        h = int(2 * this.stage.stageHeight / 3);
      }
      if (this.height < h) {
        this.y = (h - this.height) / 2;
      } else {
        this.y = 30;
      }
      _duration = Math.ceil(info["duration"]);
      // this._protectTimer.delay = (_duration + 5) * 1000;
      // this._protectTimer.start();
    }

    public function onCuePoint(info:Object):void {
      trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    }

    public function onXMPData(info:Object):void {
      trace("[Client/onXMPData] " + JSON.stringify(info));
    }

    public function onPlayStatus(info:Object):void {
      trace("[Client/onPlayStatus]" + JSON.stringify(info));
    }
  }
}

class Client extends Object {
}