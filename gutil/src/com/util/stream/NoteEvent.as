/**
 * Created by wbguan on 2015/6/26.
 */
package com.util.stream {
  import flash.events.Event;

  public class NoteEvent extends Event {
    public static const ACTION_COMPLETE:String = "ACTION_COMPLETE";
    public function NoteEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new NoteEvent(type,bubbles,cancelable);
    }
  }
}
