/**
 * Created by wbguan on 2015/4/24.
 */
package util.net {

  import util.net.socket.SocketEvent;
  import util.net.socket.SocketServer;

  public class Receiver extends Object {
    private var _socket:SocketServer;
    private var _callBack:Function;
    private var jsonStringNotReady:String;
    private var _buffer:Array = [];

    public function Receiver() {
      super();
    }

    public function init(param:SocketServer,callBack:Function):void{
      _socket = param;
      _callBack = callBack;
      _socket.addEventListener(SocketEvent.RECEIVED,onReceived);
    }
    public function dispose():void{
      _socket.removeEventListener(SocketEvent.RECEIVED,onReceived);
      _callBack = null;
    }
    private function onReceived(event:SocketEvent):void {
      dataHandler(event.data as String);
      if(_callBack != null){
        while(_buffer.length>0){
          var str:String = _buffer.shift();
          _callBack(str);
        }
      }
    }

    private function dataHandler(source:String):void {
      var rawString:String;
      if (jsonStringNotReady) {
        rawString = jsonStringNotReady + source;
      } else {
        rawString = source;
      }

      // parse new string
      var needPackage:Boolean = needToPackage(rawString);
      var sourceList:Array = parseRawString(rawString);
      if (needPackage) {
        jsonStringNotReady = sourceList.pop();
      }

      if (sourceList.length <= 0) {
        return;
      }
      this._buffer = sourceList;
      if (!needPackage) {
        jsonStringNotReady = null;
      }
    }
    private function parseRawString(source:String):Array {
      var array:Array = source.split(this._socket.split);
      return array.filter(filterMessageString);
    }
    private function filterMessageString(element:String, index:int, arr:Array):Boolean {
      return element.length > 0;
    }

    private function needToPackage(source:String):Boolean {
      if (!source) {
        return false;
      }
      var lastChar:String = source.substr(source.length-2, 2);
      if (lastChar != this._socket.split) {
        return true;
      }
      return false;
    }

  }
}
