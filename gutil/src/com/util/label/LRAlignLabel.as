/**
 * Created by wbguan on 2015/5/26.
 */
package com.util.label {
  import flash.display.DisplayObject;

  public class LRAlignLabel extends Object {
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";
    public static const CENTER:String = "center";
    public static const JUSTIFY:String = "justify";
    private var _w:int = 0;
    private var _align:String = "";
    private var _key:DisplayObject;
    private var _value:DisplayObject;
    private var _margin:int = 0;
    public function LRAlignLabel(w:int,align:String = "left"){
      super();
      _align = align;
      _w = w;
    }
    public function render():void{
      var func:Function = this[_align];
      if(func != null){
        func();
      }
    }
    private function justify():void{
      _key.x = 0;
      _value.x = _w - _value.width;
    }
    private function left():void{
      _key.x = 0;
      _value.x = _key.width + _margin;
    }
    private function right():void{
      _value.x = _w - _value.width;
      _key.x = _value.x - _key.width-_margin;
    }
    private function center():void{
      _value.x = int(_w/2);
      _key.x = int(_w/2) -_key.width-_margin;
    }

    public function setKey(param:DisplayObject):void{
      _key = param;
          }

    public function setValue(param:DisplayObject):void{
      _value = param;
    }

    public function get key():DisplayObject {
      return _key;
    }

    public function get value():DisplayObject {
      return _value;
    }

  }
}
