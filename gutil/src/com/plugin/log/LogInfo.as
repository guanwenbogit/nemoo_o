/**
 * Created by wbguan on 2015/8/25.
 */
package com.plugin.log {
  public class LogInfo {
    private var _type:String = "";
    private var _content:String = "";

    public function LogInfo() {
    }

    public function get type():String {
      return _type;
    }

    public function get content():String {
      return _content;
    }

    public function set type(value:String):void {
      _type = value;
    }

    public function set content(value:String):void {
      _content = value;
    }
  }
}
