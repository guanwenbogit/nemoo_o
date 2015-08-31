package com.util.ui.flv {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class LRFLVEvent extends Event {
    public static const START:String = "start";
    public static const STOP:String = "stop";
    public static const ERROR:String = "ERROR";
    public static const NOT_FOUND:String = "NOT_FOUND";
    public function LRFLVEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }
    
    override public function clone():Event{
      return new LRFLVEvent(this.type,this.bubbles,this.cancelable);
    }
  }
}
