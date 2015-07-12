/**
 * Created by wbguan on 2015/4/14.
 */
package util.ui.scrollbar {
  import flash.events.Event;

  public class LRSelectedListEvent extends Event {
    private var _data:Object ;
    public static const CLICK_ELEMENT:String= "CLICK_ELEMENT";
    public function LRSelectedListEvent(type:String,data:Object, bubbles:Boolean = true, cancelable:Boolean = false) {
      this._data = data;
      super(type, bubbles, cancelable);
    }
    /*
    * index of the ele
    * */
    public function get data():Object {
      return _data;
    }
    override public function clone():Event{
      return new LRSelectedListEvent(this.type, this._data,this.bubbles,this.cancelable);
    }
  }
}
