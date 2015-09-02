/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.framework.event {
  import flash.events.Event;

  public class SimpleEvent extends Event {
    private var _data:Object;
    public function SimpleEvent(type:String, data:Object,bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      _data = data;
    }

    override public function clone():Event {
      return new SimpleEvent(type,_data,bubbles,cancelable);
    }
  }
}
