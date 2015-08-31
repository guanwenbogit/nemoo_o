/**
 * Created by wbguan on 2015/6/25.
 */
package com.util.stream {

  import flash.events.EventDispatcher;

  public class NoteStream extends EventDispatcher {
    private var _buffer:Vector.<Note> = new <Note>[];
    private var _running:Boolean = false;
    private var _hz:int = 50;
    private var _current:Note;

    public function get id():int {
      return _id;
    }

    private var _id:int = -1;
    public function NoteStream() {
      super(null);
      initInstance();
    }

    private function initInstance():void{

    }

    public function append(note:Note):void{
      _buffer.push(note);
      check();
    }
    private function check():void {
      if(!_running){
        var note:Note = _buffer.shift();
        _current = note;
        if(note !=null&&note.obj.length>0) {
          note.addEventListener(NoteEvent.ACTION_COMPLETE,onNotComplete);
          this.dispatchEvent(new NoteStreamEvent(NoteStreamEvent.NOTE_START,note));
          note.action();
          _running = true
        }else{
          _current = null;
          this.dispatchEvent(new NoteStreamEvent(NoteStreamEvent.STREAM_EMPTY,null));
          _running = false;
        }
      }
    }

    private function onNotComplete(event:NoteEvent):void {
      var target:Note = event.target as Note;
      this.dispatchEvent(new NoteStreamEvent(NoteStreamEvent.NOTE_COMPLETE,target));
      _running = false;
      check();
    }

    public function set id(value:int):void {
      _id = value;
    }

    public function complete():void {
      while(_buffer.length>0){
        _buffer.pop();
      }
      if(_current !=null){
        _current.finish();
      }
      trace("note complete");
    }

    public function get running():Boolean {
      return _running;
    }
  }
}
