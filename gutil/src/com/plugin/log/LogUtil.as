/**
 * Created by wbguan on 2015/8/25.
 */
package com.plugin.log {
  import flash.display.Stage;
  import flash.events.Event;
  import flash.net.FileReference;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

  public class LogUtil {
    private static var stage:Stage;
    private static var running:Boolean;
    private static var txt:TextField;
    private static const LIMIT:int = 5000;
    public static function init(param:Stage):void{
      stage = param;
      txt = new TextField();
      txt.autoSize = TextFieldAutoSize.LEFT;
      txt.text = "loading log ... ";
    }
    public static function info(content:String,clazz:String="",print:Boolean = true):void{
      var str:String = clazz + " : "+content;
      Log.info(content);
      if(print){
        trace("[INFO] "+str);
      }
    }
    public static function error(content:String,clazz:String="",print:Boolean = true):void{
      var str:String = clazz + " : "+content;
      Log.error(content);
      if(print){
        trace("[ERROR] " + str);
      }
    }
    public static function warning(content:String,clazz:String="",print:Boolean = true):void{
      var str:String = clazz + " : "+content;
      Log.warning(content);
      if(print){
        trace("[WARNING] " + str);
      }
    }
    public static function exportFile():void{
      var arr:Array = Log.buffer;
      buffer = "";
      if(arr.length>LIMIT){
        if(stage!=null&&!running){
          running = true;
          end = arr.length;
          stage.addEventListener(Event.ENTER_FRAME, onFrame);
          stage.addChild(txt);
        }
      }else{
        for each(var info:LogInfo in arr){
          buffer += "["+info.type +"] " + info.content + "\n\r";
        }
        save();
      }

    }

    private static function onFrame(event:Event):void {
      var n:int = counter+LIMIT;
      for(;counter<n;counter++){
        if(counter<end){
          var info:LogInfo = Log.buffer[counter];
          buffer += "["+info.type +"] " + info.content + "\n\r";
        }else{
          stage.removeEventListener(Event.ENTER_FRAME, onFrame);
          running =false;
          end = 0;
          stage.removeChild(txt);
          counter = 0;
          save();
          break;
        }
      }
    }

    private static var buffer:String = "";
    private static var end:int = 0;
    private static var counter:int = 0;
    private static function save():void{
      var file:FileReference;
      file = new FileReference();
      file.save(buffer,"log"+".log");
    }
    public function LogUtil() {
    }
  }
}
