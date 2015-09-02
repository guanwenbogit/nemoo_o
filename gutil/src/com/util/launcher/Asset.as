package com.util.launcher {
  import flash.display.BitmapData;
  import flash.display.DisplayObject;

  /**
   * @author wbguan
   */
  public class Asset extends Object {
    //----------------------------------
    //  name
    //----------------------------------
    private var _name:String;
    public function get name():String {
      return _name;
    }
    public function set name(value:String):void {
      _name = value;
    }
    //----------------------------------
    //  isRetry
    //----------------------------------
    private var _isRetry:Boolean;
    public function get isRetry():Boolean {
      return _isRetry;
    }
    public function set isRetry(value:Boolean):void {
      _isRetry = value;
    }
    //----------------------------------
    //  url
    //----------------------------------
    private var _url:String;
    public function get url():String {
      return _url;
    }
    public function set url(value:String):void {
      _url = value;
    }
    private var _displayObj:DisplayObject
    private var _content:Object;
    public function Asset() {
    }

    public function set content(value:Object):void {
      _content = value;
    }

    public function get displayObj():DisplayObject {
      return _displayObj;
    }

    public function set displayObj(value:DisplayObject):void {
      _displayObj = value;
    }

    public function get content():Object {
      return _content;
    }
  }
}
