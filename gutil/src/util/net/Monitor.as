/**
 * Created by wbguan on 2015/4/24.
 */
package util.net {
  import com.util.net.socket.SocketEvent;
  import com.util.net.socket.SocketServer;

  import flash.events.EventDispatcher;

  import flash.events.TimerEvent;

  import flash.utils.Timer;
  import flash.utils.getTimer;
/*
* We may ping or do some network test in the class
* */
  public class Monitor extends EventDispatcher {
    private var _socket:SocketServer;
    private var _hearBeat:Timer = new Timer(1000);
    private var _ping:Number;
    public function Monitor() {
      super();
    }
    public function init(param:SocketServer):void{
      _socket = param;
      _socket.addEventListener(SocketEvent.CLOSE,onClose);
      _socket.addEventListener(SocketEvent.IO_ERROR,onError);
      _socket.addEventListener(SocketEvent.SECURITY_ERROR,onError);
      _socket.addEventListener(SocketEvent.CONNECTED,onConnected);
      _hearBeat.addEventListener(TimerEvent.TIMER, onHearBeat);
      _hearBeat.start();
    }
    public function dispose():void{
      _hearBeat.stop();
      _socket.removeEventListener(SocketEvent.CLOSE,onClose);
      _socket.removeEventListener(SocketEvent.IO_ERROR,onError);
      _socket.removeEventListener(SocketEvent.SECURITY_ERROR,onError);
      _socket.removeEventListener(SocketEvent.CONNECTED,onConnected);
      _hearBeat.removeEventListener(TimerEvent.TIMER, onHearBeat);
    }
    private function onHearBeat(event:TimerEvent):void {
      var span:Number = getTimer();
      span = span -  _socket.lastTime;
      if(span>=30000 &&_socket.isConnected){
        var timeStamp:uint = (new Date()).getTime()/1000;
        _socket.send(JSON.stringify({"t":timeStamp}));
      }
    }
    private function onConnected(event:SocketEvent):void {

    }

    private function onError(event:SocketEvent):void {

    }

    private function onClose(event:SocketEvent):void {

    }

    public function get ping():Number {
      return _ping;
    }
  }
}
