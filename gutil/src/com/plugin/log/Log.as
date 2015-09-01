/**
 * Created by wbguan on 2015/8/25.
 */
package com.plugin.log {
  public class Log {
    private static const MAX:int = 100000;
    public static var buffer:Array = []
    public function Log() {
    }

    public static function info(content:String):void{
      var info:LogInfo = createInfo();
      info.type = "info";
      info.content = content;
    }

    public static function warning(content:String):void{
      var info:LogInfo = createInfo();
      info.type = "warning";
      info.content = content;
    }

    public static function error(content:String):void{
      var info:LogInfo = createInfo();
      info.type = "error";
      info.content = content;
    }
    private static function createInfo():LogInfo{
      var info:LogInfo;
      if(buffer.length<MAX) {
        info = new LogInfo();
      }else{
        info = buffer.shift();
      }
      buffer.push(info);
      return info;
    }
  }
}
