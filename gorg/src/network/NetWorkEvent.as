/**
 * Created by wbguan on 2015/1/27.
 */
package network {
  import flash.events.Event;

  public class NetWorkEvent extends Event {
    public static const RECEIVE_DATA:String = "RECEIVE_DATA";
    public static const CONNECTED:String = "CONNECTED";
    private var _data:Object ;
    public function NetWorkEvent(type:String, data:Object, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      this._data = data;
    }

    override public function clone():Event {
      return new NetWorkEvent(this.type,this._data,this.bubbles,this.cancelable)
    }

    public function get data():Object {
      return _data;
    }
  }
}
