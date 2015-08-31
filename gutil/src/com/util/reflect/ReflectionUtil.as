/**
 * Created by wbguan on 2015/3/5.
 */
package com.util.reflect {
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.system.ApplicationDomain;

  public class ReflectionUtil {
    protected static var buffer:Object = {};
    public function ReflectionUtil() {
    }

    protected static function getClass(name:String):Class{
      var result:Class;
//      if(ApplicationDomain.currentDomain.hasDefinition(name)){
        result = ApplicationDomain.currentDomain.getDefinition(name) as Class;
//      }
      return result;
    }

    public static function getObj(name:String):Object{
      var result:Object;
      var clazz:Class = getClass(name);
      if(clazz != null){
        result = new clazz();
      }
      return result;
    }
    public static function getDisplayObj(name:String):DisplayObject{
      var result:DisplayObject;
      var obj:Object = getObj(name);
      if(obj != null){
        result = obj as DisplayObject;
      }
      return result;
    }
    public static function getBitmapData(name:String):BitmapData{
      var result:BitmapData;
      result = buffer[name];
      if(result == null) {
        var obj:Object = getObj(name);
        result = obj as BitmapData;
        if (result != null) {
          buffer[name] = result;
        }
      }
      return result;
    }

    public static function removeAll():void {
      for(var key:String in buffer){
        var data:BitmapData = buffer[key];
        if(data != null) {
          data.dispose();
        }
        buffer[key] = null;
      }
    }

  }
}
