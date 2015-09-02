/**
 * Created by wbguan on 2015/5/5.
 */
package bobo.util.app {
  import flash.events.Event;

  public class AppEvent extends Event {
    public static const CLOSE:String = "CLOSE";
    public static const DISPOSE:String = "DISPOSE";
    public static const SWF_LOADED:String = "SWF_LOADED";
    public static const ATTESTED:String = "CONNECTION_READY";
    public static const NEW_INSTANCE:String = "NEW_INSTANCE";

    public function AppEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
  }
}
