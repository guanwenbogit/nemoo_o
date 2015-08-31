/**
 * Created by wbguan on 2015/6/25.
 */
package com.util.stream {
  import flash.display.DisplayObject;
  import flash.events.EventDispatcher;
  import flash.geom.Point;



  public class Note extends EventDispatcher{
    protected var _name:String = "";
    private var _id:int = 0;
    protected var _obj:Vector.<DisplayObject> = new <DisplayObject>[];
    protected var _source:Point = new Point();
    protected var _target:Point = new Point();

    public function Note() {
      super();
    }

    public function get name():String {
      return _name;
    }

    public function set name(value:String):void {
      _name = value;
    }

    public function get source():Point {
      return _source;
    }

    public function set source(value:Point):void {
      _source = value;
    }

    public function get target():Point {
      return _target;
    }

    public function set target(value:Point):void {
      _target = value;
    }

    public function get obj():Vector.<DisplayObject> {
      return _obj;
    }
    public function action():void{
      complete();
    }
    protected function complete():void{
      this.dispatchEvent(new NoteEvent(NoteEvent.ACTION_COMPLETE));
    }

    public function finish():void {
      complete();
    }

    public function get id():int {
      return _id;
    }

    public function set id(value:int):void {
      _id = value;
    }
  }
}
