/**
 * Created by wbguan on 2015/6/25.
 */
package util.stream {

  import flash.events.Event;

  public class NoteStreamEvent extends Event {

    public static const NOTE_COMPLETE:String = "NOTE_COMPLETE";
    public var note:Note;
    public static const NOTE_START:String = "NOTE_START";
    public static const STREAM_EMPTY:String = "STREAM_EMPTY";
    public function NoteStreamEvent(type:String, param:Note,bubbles:Boolean = true, cancelable:Boolean = false) {
      note = param;
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new NoteStreamEvent(type,note,bubbles,cancelable);
    }
  }
}
