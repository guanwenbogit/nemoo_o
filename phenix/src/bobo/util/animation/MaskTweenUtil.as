/**
 * Created by wbguan on 2015/9/2.
 */
package bobo.util.animation {
  import com.greensock.TweenLite;
  import com.util.ui.shape.LRRectangle;

  import flash.display.DisplayObject;
  import flash.events.Event;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class MaskTweenUtil {
    private static var arr:Array = [];
    private static var tweens:Array = [];
    public function MaskTweenUtil() {
    }
    public static function moveOut(target:DisplayObject,callBack:Function,end:Point,rect:Rectangle = null):void{
      createMask(target,rect);
      moveTo(target,end,callBack);
    }
    public static function moveInto(target:DisplayObject,callBack:Function,start:Point,rect:Rectangle = null):void{
      createMask(target,rect);
      target.x = start.x;
      target.y = start.y;
      moveTo(target,new Point(target.mask.x,target.mask.y),callBack);
    }

    protected static function createMask(target:DisplayObject,rect:Rectangle):DisplayObject{
      var mask:DisplayObject;
      if(rect==null){
        mask = new LRRectangle(target.width,target.height,0xffffff);
        mask.x = target.x;
        mask.y = target.y;
      }else{
        mask = new LRRectangle(rect.width,rect.height,0xffffff);
        mask.x = rect.x;
        mask.y = rect.y;
      }
      removeMask(target);
      target.mask = mask;
      if(target.parent !=null){
        target.parent.addChild(mask);
      }else{
        target.addEventListener(Event.ADDED_TO_STAGE, function addedFunc(event:Event){
          target.parent.addChild(mask);
        },false,0,true);
      }
      return mask;
    }
    public static function moveTo(target:DisplayObject,toPoint:Point,callBack:Function):void {
      var tween:TweenLite;
      removeTween(target);
      tween = TweenLite.to(target,0.2,{x:toPoint.x,y:toPoint.y,onComplete:function completeFunc(){
        removeTween(target);
        removeMask(target);
        if(callBack!=null) {
          callBack();
        }
      }});
      tweens.push(tween);
      arr.push(target);
    }
    private static function removeTween(target:DisplayObject):void{
      var index:int = arr.indexOf(target);
      var tween:TweenLite;
      if(index>=0){
        tween = tweens[index];
        if(tween!=null && tween.isActive()){
          tween.kill();
        }
        tweens.splice(index,1);
        arr.slice(index,1);
      }
    }
    private static function removeMask(target:DisplayObject):void{
      if(target!=null){
        if(target.mask!=null&&target.mask.parent!=null){
          target.mask.parent.removeChild(target.mask);
        }
        target.mask = null;
      }

    }

  }
}
