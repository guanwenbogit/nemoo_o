/**
 * Created by wbguan on 2015/4/24.
 */
package util.net.sdk {
  import flash.events.Event;

  public class ConnectionEvent extends Event {
    public static const RECEIVED:String ="RECEIVED" ;
    private var _data:Object;
    public static const CONNECTED:String = "CONNECTED";
    public static const CAN_NOT_CONNECT:String = "CAN_NOT_CONNECT";
    public static const CRASH:String = "CRASH";
    public function ConnectionEvent(type:String, data:Object,bubbles:Boolean = false, cancelable:Boolean = false) {
      this._data = data;
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new ConnectionEvent(type,_data,bubbles,cancelable);
    }

    public function get data():Object {
      return _data;
    }
  }
}
