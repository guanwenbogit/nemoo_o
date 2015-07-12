/**
 * Created by wbguan on 15/7/11.
 */
package state {
import flash.events.Event;

public class ExeEvent extends Event {
  public static const COMPLETE:String = "COMPLETE";
  public static const START:String = "START";
  public function ExeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
    super(type, bubbles, cancelable);
  }
}
}
