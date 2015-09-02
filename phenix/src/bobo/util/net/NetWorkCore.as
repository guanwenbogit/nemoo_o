/**
 * Created by wbguan on 2015/5/5.
 */
package bobo.util.net {

  import com.util.net.Connection;
  import com.util.net.sdk.ConnectionEvent;
  import com.util.net.sdk.IConnection;
  import flash.events.Event;
  import flash.events.EventDispatcher;

  public class NetWorkCore extends EventDispatcher implements IConnection{
    private var _connection:Connection;
    private var _login:Login;
    private var _ready:Boolean = false;

    private function initInstance():void{
      _connection = new Connection();
      _login = new Login();
      _login.addEventListener(Event.COMPLETE,onLogin);
      _connection.addEventListener(ConnectionEvent.CONNECTED,onConnected);
    }
    private function onConnected(event:ConnectionEvent):void {
      _ready = true;
    }

    private function onLogin(event:Event):void {
      var data:Object = _login.data
      var addr : String = data["domain"];
      var port : int = data["port"];
      this.connect(addr,port);
    }
    protected function connect(addr:String,port:int):void{
      if(_connection != null && !_connection.connected){
        _connection.connect(addr,port);
      }
    }

    public function NetWorkCore() {
      super(null);
      initInstance();
    }
    public function login(url:String,userId:String,roomId:int):void{
      if(_login != null){
        _login.login(url,userId,roomId);
      }
    }
    public function send(obj:String):void{
      _connection.send(obj);
    }

    override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      _connection.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      _connection.removeEventListener(type, listener, useCapture);
    }

    override public function dispatchEvent(event:Event):Boolean {
      return _connection.dispatchEvent(event);
    }

    override public function hasEventListener(type:String):Boolean {
      return _connection.hasEventListener(type);
    }

    public function get ready():Boolean {
      return _ready;
    }

    public function get connected():Boolean {
      return this._connection.connected;
    }

    public function reconnect():void {
      if(_connection!= null){
        _connection.reconnect();
      }
    }
  }
}
