package tools.player {
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.NetStatusEvent;
  import flash.events.SecurityErrorEvent;
  import flash.events.TimerEvent;
  import flash.media.SoundTransform;
  import flash.net.NetConnection;
  import flash.net.NetStream;
  import flash.utils.Timer;
  import flash.utils.getTimer;

  public class PlayerManager extends EventDispatcher {
    public static const FAILED : String = "failed";
    public static const VOLUME_CHANGE : String = "volumeChange";

    //这里填的太小，chrome浏览器播放一些流时可能会声画不同步
    private var BUFFER_TIME:Number = 1.5;

    private var nc:NetConnection;
    private var ns:NetStream;
    private var soundTransform:SoundTransform = new SoundTransform(0.5);

    private var reconnTimer:Timer = new Timer(5000);
    private var reconnCount:int = 0;
    private const maxReconnCount:int = 20;

    private var emptyTimer:Timer = new Timer(30000);

    public var streamUrl:String = "";

    private var _playing : Boolean = false;
    public function get playing():Boolean {
      return _playing;
    }


    private var _updateJitterTimer:Timer = null;
    private var _jitter:JitterBuffer = null;
    private var _lastSeekTime:Number = 0; //seek.notify时赋值





    public function PlayerManager() {
      nc = new NetConnection();
      nc.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true);
      nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, netConnectionSecurityHandler, false, 0, true);
      nc.connect(null);

      ns = new FLVNetStream(nc);
//      ns = new NetStream(nc);
      ns.bufferTime = 0.5;
      ns.soundTransform = soundTransform;

      ns.client = this;

      ns.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler, false, 0, true);

      reconnTimer.addEventListener(TimerEvent.TIMER, reconnHandler, false, 0, true);
      emptyTimer.addEventListener(TimerEvent.TIMER, emptyHandler, false, 0, true);


      _jitter = new JitterBuffer(60, true, 2.0, 1000, 5000);
      _updateJitterTimer = new Timer(1000 / _jitter.fps);
      _updateJitterTimer.addEventListener(TimerEvent.TIMER, onUpdateJitter);


    }

    public function play(url:String):void {
//      Cc.debug("PlayerManager play", url);
      close();
      this.streamUrl = url;
      ns.play(streamUrl + "?t=" + new Date().time);
      _playing = true;

      if (_jitter) {
        _jitter.clear();
        _updateJitterTimer.start();
      }

      dispatchEvent(new Event(Event.OPEN));
    }

    public function replay() : void {
//      Cc.debug("PlayerManager replay");
      play(streamUrl);
    }

    public function set volume(value:Number):void {
      if(value < 0) value = 0;
      if(value > 1) value = 1;
      soundTransform.volume = value;
      ns.soundTransform = soundTransform;
//      Storage.write(Storage.VOLUME, value);
      dispatchEvent(new Event(PlayerManager.VOLUME_CHANGE));
    }

    public function get volume():Number {
      return soundTransform.volume;
    }

    public function get netstream():NetStream {
      return ns;
    }

    public function close():void {
//      Cc.debug("PlayerManager close");
      reconnCount = 0;
      ns.close();
      if (reconnTimer.running) reconnTimer.stop();
      if (emptyTimer.running) emptyTimer.stop();
      _playing = false;

      if(_updateJitterTimer.running){
        _updateJitterTimer.stop();
      }

      dispatchEvent(new Event(Event.CLOSE))
    }

    private function netConnectionSecurityHandler(event:SecurityErrorEvent):void {
//      Cc.debug("netConnectionSecurityHandler");
    }

    private function netStatusHandler(e:NetStatusEvent):void {
//      Cc.debug("netStatusHandler", _playing, e.info.code);
      if(_playing){
        dispatchEvent(e.clone());
      }
      switch (e.info.code) {
        case "NetConnection.Connect.Success":

          break;
        case "NetConnection.Connect.Failed":

          break;
        case "NetStream.Play.StreamNotFound":
          //重连
          if(_playing){
            reconnTimer.reset();
            reconnTimer.start();
          }
          _updateJitterTimer.stop();
          break;
        case 'NetStream.Seek.Notify':
          break;
        case 'NetStream.Buffer.Empty':
          //卡了，要做超时重连
          if(_playing) {
            emptyTimer.start();
          }
          break;
        case "NetStream.Buffer.Full":
          if(ns.bufferTime != BUFFER_TIME){
            ns.bufferTime = BUFFER_TIME;
          }
          if (reconnTimer.running) reconnTimer.stop();
          if (emptyTimer.running) emptyTimer.stop();
          break;
        case "NetStream.Play.Start":
          if (reconnTimer.running) reconnTimer.stop();
          if (emptyTimer.running) emptyTimer.stop();
          break;
        case "NetStream.Play.Stop":
          if (reconnTimer.running) reconnTimer.stop();
          if (emptyTimer.running) emptyTimer.stop();
          _playing = false;
          break;

      }
    }

    private function reconnHandler(e:TimerEvent):void {
      reconnTimer.stop();
      reconn();
    }

    private function emptyHandler(e:TimerEvent):void {
      emptyTimer.stop();
      reconn();
    }

    private function reconn():void {
      reconnCount++;
      if (reconnCount < maxReconnCount) {
        ns.close();
        if (_jitter) {
          _jitter.clear();
          _updateJitterTimer.start();
        }
        ns.play(streamUrl + "?t=" + new Date().time);
      }
      else {
        if(_updateJitterTimer.running){
          _updateJitterTimer.stop();
        }
        dispatchEvent(new Event(PlayerManager.FAILED));
      }
    }

    private function onUpdateJitter(event:TimerEvent):void {
      if (_jitter) {
        _jitter.updateBufferTime(this.ns.bufferLength, this.ns.time, FLVNetStream(ns).lastAudioTime);
        var remainAfterSeek:Number = _jitter.remainAfterSeek;
        if (remainAfterSeek < ns.bufferTime) {
          remainAfterSeek = ns.bufferTime;
        }
        if (this.ns.bufferLength > remainAfterSeek) {
          //离上次快进超过特定时间。两次快进需超过一定时间（30s or 60s）
          if (_lastSeekTime <= 0 || new Date().time - _lastSeekTime > _jitter.buffertime * 1000) {
            FLVNetStream(ns).remainAfterSeek = remainAfterSeek * 1000;
            ns.seek(-1);
          }
        }
      }
    }


    public function onMetaData(info:Object):void {
//      Cc.debug("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
    }

    public function onCuePoint(info:Object):void {
//      Cc.debug("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
    }

    public function onPlayStatus(...args):void {
//      Cc.debug("onPlayStatus");
    }

  }
}
