package com.util.ui.scrollbar {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class LRScrollerEvent extends Event {
    public static const END_EVENT:String = "END_EVENT";
    public static const HEADER_EVENT:String = "HEADER_EVENT";
    public static const BAR_UP:String = "BAR_UP";
    public function LRScrollerEvent(type : String, bubbles : Boolean = true, cancelable : Boolean = false) {
      super(type, bubbles, cancelable);
    }
    
    override public function clone():Event{
      return new LRScrollerEvent(type,bubbles,cancelable);
    }
    
  }
}
