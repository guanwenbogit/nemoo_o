/**
 * Created by wbguan on 2015/5/4.
 */
package com.util.tween {
  import com.greensock.TweenLite;
  import com.greensock.easing.Bounce;

  import flash.display.DisplayObject;
  import flash.geom.Point;

  public class TweenUtil extends Object {
    private static var _map:Object = {};
    public function TweenUtil() {
      super();
    }
    public static function moveToWithsParams(target:DisplayObject, origin:Point, dest:Point,delay:Number = 0.2,
                                  callBack:Function = null,
                                  reset:Boolean = false,
                                  oScale:Number=1.0,
                                  scale:Number=1.0,params:Object = null):TweenLite {
      var result:TweenLite;
      result = _map[target.name];
      var flag:Boolean = true;
      if(result != null&&result.isActive()){
        result.progress(1);
        flag = false;
      }
      if(flag) {
        result = TweenLite.fromTo(target, delay, {x: origin.x, y: origin.y,scaleX:oScale,scaleY:oScale, ease: Bounce.easeInOut}, {
          x: dest.x,
          y: dest.y,
          scaleX:scale,scaleY:scale,
          onComplete: onCompleteParams,
          onCompleteParams: [target, callBack, reset, origin,oScale,params]
        });
        _map[target.name] = result;
      }else{
        if(callBack != null){
          callBack(target,params);
        }
      }
      return result;
    }
    public static function moveTo(target:DisplayObject, origin:Point, dest:Point,
                                  delay:Number = 0.2,
                                  callBack:Function = null,
                                  reset:Boolean = false,
                                  oScale:Number=1.0,
                                  scale:Number=1.0):TweenLite {
      var result:TweenLite;
      result = _map[target.name];
      var flag:Boolean = true;
      if(result != null&&result.isActive()){
        result.progress(1);
        flag = false;
      }
      if(flag) {
        result = TweenLite.fromTo(target, delay, {x: origin.x, y: origin.y,scaleX:oScale,scaleY:oScale, ease: Bounce.easeInOut}, {
          x: dest.x,
          y: dest.y,
          scaleX:scale,scaleY:scale,
          onComplete: onComplete,
          onCompleteParams: [target, callBack, reset, origin,oScale]
        });
        _map[target.name] = result;
      }else{
        if(callBack != null){
          callBack(target);
        }
      }
      return result;
    }
    private static function onCompleteParams(target:DisplayObject, callBack:Function, reset:Boolean, point:Point,oScale:Number,params:Object):void {
      trace("on complete reset " +reset);
      if (callBack != null) {
        callBack(target,params);
      }
      if (reset) {
        target.x = point.x;
        target.y = point.y;
        target.scaleX =target.scaleY =oScale;
      }
      _map[target.name] = null;
      delete _map[target.name];
    }
    private static function onComplete(target:DisplayObject, callBack:Function, reset:Boolean, point:Point,oScale:Number):void {
      trace("on complete reset " +reset);
      if (callBack != null) {
        callBack(target);
      }
      if (reset) {
        target.x = point.x;
        target.y = point.y;
        target.scaleX =target.scaleY =oScale;
      }
      _map[target.name] = null;
      delete _map[target.name];
    }
  }
}
