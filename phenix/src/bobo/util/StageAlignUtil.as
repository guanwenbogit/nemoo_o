/**
 * Created by wbguan on 2015/6/10.
 */
package bobo.util {
  import flash.display.DisplayObject;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Rectangle;


  public class StageAlignUtil extends Object {
    private static var _centers:Array = [];
    private static var _rectCenters:Array = [];
    private static var _rectBottom:Array = [];
    private static var _stage:Stage;
    public function StageAlignUtil() {
      super();
    }
    public static function init(stage:Stage):void{
      _stage = stage;
      _stage.addEventListener(Event.RESIZE, onStageResize);
    }

    public static function rectCenter(rect:Rectangle,target:DisplayObject):void {
      target.addEventListener(Event.REMOVED_FROM_STAGE, onRectRemove);
      _rectCenters.push(target);
      target.x = int((rect.width - target.width)/2+rect.x);
      target.y = int((rect.height - target.height+rect.y)/2);
    }
    public static function rectBottom(rect:Rectangle,target:DisplayObject):void {
      target.addEventListener(Event.REMOVED_FROM_STAGE, onRectRemove);
      _rectBottom.push(target);
      target.y = rect.height - target.height+rect.y;
    }
    public static function stageCenter(target:DisplayObject):void{
      target.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
      _centers.push(target);
      target.x = int((_stage.stageWidth - target.width)/2);
      target.y = int((_stage.stageHeight - target.height)/2);
    }
    private static function onRectRemove(event:Event):void {
      var target:DisplayObject = event.currentTarget as DisplayObject;
      target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
      var index:int = _rectCenters.indexOf(_centers);
      if(index>=0) {
        _centers.splice(index, 1);
      }
    }
    private static function onRemove(event:Event):void {
      var target:DisplayObject = event.currentTarget as DisplayObject;
      target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
      var index:int = _centers.indexOf(_centers);
      if(index>=0) {
        _centers.splice(index, 1);
      }
    }

    private static function onStageResize(event:Event):void {
      for each(var obj:DisplayObject in _centers){
        obj.x = int((_stage.stageWidth - obj.width)/2);
        obj.y = int((_stage.stageHeight - obj.height)/2);
      }
    }
    public static function dispose():void{
      _stage.removeEventListener(Event.RESIZE, onStageResize);
      _stage = null;
      while(_centers.length>0){
        var obj:DisplayObject = _centers.pop();
        obj.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
      }
    }

  }
}
