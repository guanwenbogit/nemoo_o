/**
 * Created by wbguan on 2015/4/28.
 */
package bobo.util.app.framework {
  import com.util.net.sdk.ConnectionEvent;
  import com.util.net.sdk.IConnection;

  import org.osflash.signals.Signal;

  public class NetWork extends Object {
    private var _core:IConnection;
    private var _params:Object;
    //signals
    /*
     * callBack(param:String)
     * */
    public var receiveSignal:Signal = new Signal();

    public var connectionReadySignal:Signal = new Signal();

    public function NetWork() {
      super();
    }
    public function dispose():void{
      _core.removeEventListener(ConnectionEvent.RECEIVED, onReceived);
      _core.removeEventListener(ConnectionEvent.CONNECTED, onConnected);
      _core.removeEventListener(ConnectionEvent.CRASH, onCrash);
      _core = null;
    }
    public function init(param:Object, core:IConnection):void {
      _params = param;
      check();
      _core = core;
      _core.addEventListener(ConnectionEvent.RECEIVED, onReceived);
      _core.addEventListener(ConnectionEvent.CONNECTED, onConnected);
      _core.addEventListener(ConnectionEvent.CRASH, onCrash);
    }
    public function setCore(param:Object, core:IConnection):void {
      _params = param;
      check();
      _core = core;

    }

    private function onCrash(event:ConnectionEvent):void {
      _core.reconnect();
    }

    private function onConnected(event:ConnectionEvent):void {
      connectionReadySignal.dispatch();
    }

    private function onReceived(event:ConnectionEvent):void {
      var param:String = String(event.data);
//      trace("[NetWork]onReceived: " + param);
      receiveSignal.dispatch(param);
    }

    private function check():void {
      if (this._core != null) {

      }
    }

    public function login(url:String, userId:String, roomId:int):void {
      if (_core != null) {
        _core.login(url, userId, roomId);
      }
    }

    public function send(obj:String):void {
      _core.send(obj);
    }

    public function get ready():Boolean {
      return _core.ready;
    }

    public function get core():IConnection {
      return _core;
    }

    public function showAnchor():void {

    }
  }
}
