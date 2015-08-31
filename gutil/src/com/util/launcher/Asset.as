package com.util.launcher {
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
    public function Asset() {
    }
  }
}
