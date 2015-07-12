package util.ui.list {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class LRRadioBtnEvent extends Event {
    public static const CHANGE_EVENT:String = "CHANGE_EVENT";
    public var data:Object ;
    public function LRRadioBtnEvent(type:String,data:Object, bubbles:Boolean = true, cancelable:Boolean = false) {
      this.data = data;
      super(type, bubbles, cancelable);
    }
    override public function clone():Event{
      return new LRRadioBtnEvent(type, data,bubbles,cancelable);
    }
  }
}
