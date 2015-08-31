package com.util.ui.scrollbar {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class LRDragScrollerEvent extends Event {
    private var _data:Object;
    public static const INSERT_EVENT:String = "INSERT_EVENT";
    public static const CLICK_EVENT:String = "CLICK_EVENT";
    public function LRDragScrollerEvent(type:String,data:Object, bubbles:Boolean = true, cancelable:Boolean = false) {
      this._data = data;
      super(type, bubbles, cancelable);
    }

    public function get data():Object {
      return _data;
    }
    override public function clone():Event{
      return new LRDragScrollerEvent(this.type, this._data,this.bubbles,this.cancelable);
    }
  }
}
