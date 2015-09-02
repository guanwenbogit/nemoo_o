/**
 * Created by wbguan on 2015/8/26.
 */
package bobo.util {
  import flash.display.DisplayObject;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Rectangle;

  public class AlignUtil {
    public static const V_TOP:String = "V_TOP";
    public static const V_CENTER:String = "V_CENTER";
    public static const V_BOTTOM:String = "V_BOTTOM";
    public static const H_LEFT:String = "H_LEFT";
    public static const H_CENTER:String = "H_CENTER";
    public static const H_RIGHT:String = "H_RIGHT";
    private static var _objs:Vector.<AlignInfo> = new <AlignInfo>[];
    private static var _stage:Stage;

    public static function init(stage:Stage):void{
      _stage = stage;
      _stage.addEventListener(Event.RESIZE, onResize)
    }

    private static function onResize(event:Event):void {
      for each(var info:AlignInfo in _objs){
        alignFunc(info);
      }
    }
    public static function align(target:DisplayObject,h:String,v:String):void{
      if(_stage == null) {

      }else {
        var info:AlignInfo = new AlignInfo();
        info.target = target;
        info.h = h;
        info.v = v;
        _objs.push(info);
        alignFunc(info);
      }
    }

    private static function alignFunc(info:AlignInfo):void{
      alignH(info);
      alignV(info);
    }

    private static function alignV(info:AlignInfo):void {
      if(info.v == V_CENTER){
        info.target.y =int((_stage.stageHeight - info.target.height)/2);
      }else if(info.v == V_BOTTOM){
        info.target.y =(_stage.stageHeight - info.target.height);
      }else{

      }
    }

    private static function alignH(info:AlignInfo):void {
      if(info.h == H_CENTER){
        info.target.x = int((_stage.stageWidth - info.target.width)/2);
      }else if(info.h == H_RIGHT){
        info.target.x =(_stage.stageWidth - info.target.width);
      }else{

      }
    }

  }
}
