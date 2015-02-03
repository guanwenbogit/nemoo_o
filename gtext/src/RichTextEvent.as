/**
 * Created by wbguan on 2015/1/22.
 */
package {
  import flash.events.Event;

  public class RichTextEvent extends Event {
    public static const LINK_CLICK:String = "LINK_CLICK";
    private var data:Object;
    public function RichTextEvent(type:String,data:Object, bubbles:Boolean = true, cancelable:Boolean = false) {
      this.data = data;
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new RichTextEvent(this.type,this.data,this.bubbles,this.cancelable);
    }
  }
}
