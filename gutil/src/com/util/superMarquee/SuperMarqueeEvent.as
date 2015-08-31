package com.util.superMarquee {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class SuperMarqueeEvent extends Event {
    public static const EMPTY_EVENT:String = "supermarquee_empty_event";
    public function SuperMarqueeEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
    override public function clone():Event{
      return new SuperMarqueeEvent(type,bubbles,cancelable);
    }
  }
}
