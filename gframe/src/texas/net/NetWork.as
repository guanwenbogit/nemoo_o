/**
 * Created by wbguan on 15/7/24.
 */
package texas.net {
  import flash.events.Event;

  import util.net.Connection;
  import util.net.http.HTTPCall;
  import util.net.sdk.ConnectionEvent;

  import util.net.sdk.IConnection;

  public class NetWork implements IConnection{
    private var _connect:Connection;
    private var _call:HTTPCall;

    public function NetWork() {
      initInstance();
    }
    private function initInstance():void{
      _connect = new Connection();
    }
    public function get connected():Boolean {
      return _connect.connected;
    }

    public function send(value:String):void {
      _connect.send(value);
    }

    public function login(url:String, s:String, i:int):void {
      var param:Object = {};
      _call = new HTTPCall(url,param);
      _call.load(responseHandler)
    }

    private function responseHandler(data:Object,flag:int):void {
      if(flag == 0){
        var domain:String = data["domain"];
        var port:int = data["port"];
        var policyPort:int = data["policyPort"]||843;
        _connect.addEventListener(ConnectionEvent.CONNECTED,onConnected);
        _connect.connect(domain,port,policyPort);

      }
    }

    private function onConnected(event:ConnectionEvent):void {
      _connect.addEventListener(ConnectionEvent.RECEIVED,onReceive);
    }

    private function onReceive(event:ConnectionEvent):void {

    }

    public function reconnect():void {
      this._connect.reconnect();
    }

    public function get ready():Boolean {
      return this._connect.connected;
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      this._connect.addEventListener(type,listener,useCapture,priority,useWeakReference);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      this._connect.removeEventListener(type,listener,useCapture);
    }

    public function dispatchEvent(event:Event):Boolean {
      return this._connect.dispatchEvent(event);
    }

    public function hasEventListener(type:String):Boolean {
      return false;
    }

    public function willTrigger(type:String):Boolean {
      return false;
    }
  }
}
