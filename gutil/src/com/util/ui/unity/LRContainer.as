package com.util.ui.unity {
  import Interface.IDispose;

  import flash.events.Event;
  import flash.display.Stage;
  import flash.geom.Point;
  import flash.display.DisplayObject;



  import flash.display.Sprite;

  /**
   * @author wbguan
   */
  public class LRContainer extends Sprite implements IDispose {
    private var left:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private var right:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private var bottom:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private var top:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private var center:Vector.<DisplayObject> = new Vector.<DisplayObject>();
    private var _map:Object = {};
    private var _vecs:Object = {};
    public static const LEFT:String = "left";
    public static const RIGHT:String = "right";
    public static const TOP:String = "top";
    public static const BOTTOM:String = "bottom";
    public static const CENTER:String = "center";
    private var _appstage:Stage;

    public function LRContainer() {
      _vecs[LEFT] = left;
      _vecs[RIGHT] = right;
      _vecs[BOTTOM] = bottom;
      _vecs[CENTER] = center;
      _vecs[TOP] = top;
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
      
    }

    private function getStageW():Number {
      if (_appstage != null) {
        return _appstage.stageWidth;
      } else {
        return 0;
      }
    }

    private function getStageH():Number {
      if (_appstage != null) {
        return _appstage.stageHeight;
      } else {
        return 0;
      }
    }

    private function onResize(event:Event):void {
      layout();
    }

    private function onAdded(event:Event):void {
      this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
      this._appstage = this.stage;
      this._appstage.addEventListener(Event.RESIZE, onResize);
    }

    public function addChildLayout(obj:DisplayObject, ...args):void {
      var o:Point = new Point(obj.x, obj.y);
      _map[obj] = o;
      for each (var algin:String in args) {
        var vec:Vector.<DisplayObject> = this._vecs[algin];
        if (vec != null) {
          vec.push(obj);
          var func:Function = this["layout" + algin] as Function;
          func.apply(this);
        }
        this.addChild(obj);
      }
    }

    public function remove(obj:DisplayObject):void {
      if (obj != null && this.contains(obj)) {
        this.removeChild(obj);
      }
      if (_map[obj] != null) {
        delete _map[obj] ;
      }
      for (var key:String in this._vecs) {
        var vec:Vector.<DisplayObject> = this._vecs[key];
        var i:int = vec.indexOf(obj);
        if (i >= 0) {
          vec.splice(i, 1);
        }
      }
    }

    public function refreshOrigin(obj:DisplayObject):void {
      var o:Point = _map[obj];
      if (o != null) {
        o.x = obj.x;
        o.y = obj.y;
      } else {
        o = new Point(obj.x, obj.y);
        _map[obj] = o;
      }
    }

    public function layoutObj(obj:DisplayObject):void {
      if (obj != null && this.contains(obj)) {
        for (var key:String in this._vecs) {
          var vec:Vector.<DisplayObject> = this._vecs[key];
          var i:int = vec.indexOf(obj);
          if (i >= 0) {
            var func:Function = this["layout" + key] as Function;
            func.apply(this);
          }
        }
      }
    }

    public function layout():void {
      layoutcenter();
      layoutleft();
      layouttop();
      layoutright();
      layoutbottom();
    }

    public function layoutcenter():void {
      for each (var obj:DisplayObject in this.center) {
        var o:Point = _map[obj];
        obj.x = o.x + int((this.getStageW() - obj.width) / 2);
        obj.y = o.y + int((this.getStageH() - obj.height) / 2);
      }
    }

    public function layoutleft():void {
      for each (var obj:DisplayObject in this.left) {
        var o:Point = _map[obj];
        obj.x = o.x + 0;
      }
    }

    public function layoutright():void {
      for each (var obj:DisplayObject in this.right) {
        var o:Point = _map[obj];
        obj.x = o.x + this.getStageW() - obj.width;
      }
    }

    public function layouttop():void {
      for each (var obj:DisplayObject in this.top) {
        var o:Point = _map[obj];
        obj.y = o.y + 0;
      }
    }

    public function layoutbottom():void {
      for each (var obj:DisplayObject in this.bottom) {
        var o:Point = _map[obj];
        obj.y = o.y + this.getStageH() - obj.height;
        trace("[LRContainer/layoutbottom] " + this.getStageH() + " | "+obj.height);
      }
    }

    public function dispose():void {
      while (this.numChildren > 0) {
        var obj:DisplayObject = this.getChildAt(0);
        this.remove(obj);
      }
      if(this._appstage != null){
        this._appstage.removeEventListener(Event.RESIZE, onResize);
        this._appstage = null;
      }
    }
  }
}
