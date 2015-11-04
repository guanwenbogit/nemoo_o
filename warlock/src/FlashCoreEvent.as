/**
 * Created by wbguan on 2015/5/21.
 */
package {
  import flash.events.Event;

  public class FlashCoreEvent extends Event {
    public static const SEND_MSG:String = "";
    public var data:Object;
    public function FlashCoreEvent(type:String,param:Object, bubbles:Boolean = true, cancelable:Boolean = false) {
      data = param;
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new FlashCoreEvent(this.type,data,bubbles,cancelable);
    }
  }
}
