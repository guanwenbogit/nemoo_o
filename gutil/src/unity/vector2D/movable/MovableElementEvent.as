/**
 * Created by wbguan on 2015/3/2.
 */
package unity.vector2D.movable {
  import flash.events.Event;

  public class MovableElementEvent extends Event {
    public static var SEEK_TARGET:String = "seek_target";
    public static var ARRIVE_TARGET:String = "arrive_target";

    public function MovableElementEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new MovableElementEvent(this.type,this.bubbles,this.cancelable);
    }
  }
}
