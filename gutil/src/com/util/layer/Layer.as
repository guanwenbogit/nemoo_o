/**
 * Created by wbguan on 2015/4/28.
 */
package com.util.layer {

  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Stage;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class Layer extends Object {
    public static const BG_LAYER:String = "BG_LAYER";
    public static const SCENE_LAYER:String = "SCENE_LAYER";
    public static const HUD_LAYER:String = "HUD_LAYER";
    public static const TIPS_LAYER:String = "TIPS_LAYER";

    public static const COVER_LAYER:String = "COVER_LAYER";

    private var _keys:Vector.<String> = new <String>[];
    private var _map:Object = {};


    public function Layer() {

    }

    public function getPoint(source:DisplayObject, target:String):Point {
      var result:Point;
      var t:DisplayObjectContainer = getContainer(target);
      if (t != null && source.parent!= null) {
        var rec:Point = source.parent.localToGlobal(new Point(source.x, source.y));
        result = t.globalToLocal(rec);
      }
      return result;
    }

    public function addContainer(name:String, container:DisplayObjectContainer):void {
      if (_keys.indexOf(name) < 0) {
        _map[name] = container;
        _keys.push(name);
      } else {
        throw new Error("Existed container name");
      }
    }

    public function addView(layer:String, view:IView, location:Point, bottom:Boolean = false):void {
      var c:DisplayObjectContainer = this.getContainer(layer);
      if (c != null && location!= null) {
        view.view.x = location.x;
        view.view.y = location.y;
        view.layerName = layer;
        view.show();
        if (bottom) {
          c.addChildAt(view.view, 0);
        } else {
          c.addChild(view.view);
        }
      }
      if(CONFIG::LOCALE&&location == null){
        throw new Error("Layer error the location is null");
      }
    }

    public function removeView(layer:String, view:IView, flag:Boolean = false):void {
      var c:DisplayObjectContainer = this.getContainer(layer);
      if (c != null) {
        if (c.contains(view.view)) {
          c.removeChild(view.view);
        }
      }
    }

    public function getContainer(name:String):DisplayObjectContainer {
      var result:DisplayObjectContainer;
      result = _map[name];
      return result;
    }

    public function remove(name:String):DisplayObjectContainer {
      var result:DisplayObjectContainer;
      if (_keys.indexOf(name) >= 0) {
        _keys = _keys.splice(_keys.indexOf(name), 1);
      }
      result = _map[name];
      return result;
    }

  }
}
