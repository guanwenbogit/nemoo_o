/**
 * Created by wbguan on 2015/4/24.
 */
package util.net {


  import flash.events.EventDispatcher;

  import util.net.sdk.ConnectionEvent;

  import util.net.socket.SocketEvent;

  import util.net.socket.SocketServer;

  public class Connection extends EventDispatcher{
    public static const RECONNECT_COUNT:int = 1;
    private var _retry:int = 0;
    private var _socket:SocketServer;
    private var _monitor:Monitor;
    private var _receiver:Receiver;
    private var _sender:Sender;
    private var _shutDown:Boolean = false;

    public function Connection() {
      super();

    }
    private function initInstance():void{
      if(_socket == null){
        _socket = new SocketServer();
        _monitor = new Monitor();
        _receiver = new Receiver();
        _sender = new Sender();
      }
    }
    public function connect(addr:String,port:int,policyPort:int = 843):void{
      initInstance();
      _socket.init(addr,port,policyPort);
      _receiver.init(_socket,receive);
      _sender.init(_socket);
      _monitor.init(_socket);
      _socket.connect();
      _socket.addEventListener(SocketEvent.CONNECTED,onConnected);
      _socket.addEventListener(SocketEvent.CLOSE,onClose);
      _socket.addEventListener(SocketEvent.IO_ERROR,onIOError);
      _socket.addEventListener(SocketEvent.SECURITY_ERROR,onSecurityError);
    }

    public function reconnect():void{
      _socket.reconnect();
    }

    public function send(value:String):void{
      if(this.connected) {
        this._sender.send(value);
      }
    }

    public function close():void{
      _shutDown = true;
      _socket.close();
    }

    public function dispose():void{
      _socket.close();
      _receiver.dispose();
      _monitor.dispose();
      _shutDown = false;
      _retry = 0;
      _socket = null;
      _receiver = null;
      _monitor = null;
      _sender = null;
    }
    private function receive(value:String):void{
      this.dispatchEvent(new ConnectionEvent(ConnectionEvent.RECEIVED,value));
    }
    private function onSecurityError(event:SocketEvent):void {
      trace("socket error : " + event.data);
      this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CAN_NOT_CONNECT,event.data));
    }

    private function onIOError(event:SocketEvent):void {
      trace("socket error : " + event.data);
      this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CAN_NOT_CONNECT,event.data));
    }

    private function onClose(event:SocketEvent):void {
      if(!_shutDown) {
        this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CRASH, event.data));
      }
    }

    private function onConnected(event:SocketEvent):void {
      trace("socket connect : " + event.type);
      this.dispatchEvent(new ConnectionEvent(ConnectionEvent.CONNECTED,null));
    }


    public function get connected():Boolean {
      var result:Boolean = false;
      result = this._socket != null && this._socket.isConnected;
      return result;
    }

    public function get addr():String {
      var result:String = "";
      if(_socket != null){
        result =_socket.addr;
      }
      return result;
    }

    public function get port():int {
      var result:int = -1
      if(_socket != null){
        result =_socket.port;
      }
      return result;
    }
  }
}
