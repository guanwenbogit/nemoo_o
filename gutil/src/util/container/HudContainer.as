/**
 * Created by wbguan on 2015/5/8.
 */
package util.container {
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.geom.Point;

  public class HudContainer extends Sprite {
    private var _arr:Array = [];
    private var _stage:Stage;
    private var _sw:int = 0;
    private var _sh:int = 0;

    public function HudContainer() {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
      this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
    }

    private function onRemove(event:Event):void {
      this._stage.removeEventListener(Event.RESIZE,onResize);
    }

    private function onAdded(event:Event):void {

      _stage = stage;
      _sw = _stage.stageWidth;
      _sh = _stage.stageHeight;
      this.stage.addEventListener(Event.RESIZE,onResize);
    }

    private function onResize(event:Event):void {
      trace("resize ");
      var len:int = this.numChildren;
      var child:DisplayObject;
      for (var i:int = 0 ;i<len;i++){
        child = this.getChildAt(i);
        var p:Point = new Point();
        p.x = 100*child.x/_sw;
        p.y = 100*child.y/_sh;
        _arr.push(p);
        trace("p "+p.x + " | "+p.y);
      }
      _sw = _stage.stageWidth;
      _sh = _stage.stageHeight;
      render();
    }

    private function render():void {
      var i:int = 0;
      var child:DisplayObject;
      while(_arr.length>0){
        var p:Point = _arr.shift();
        child = this.getChildAt(i);
        child.x = _sw*p.x/100;
        child.y = _sh*p.y/100;
        trace("p render "+p.x + " | "+p.y);
        trace("child render "+child.x + " | "+child.y);
        trace("stage render "+_sw + " | "+_sh);
        i++;
      }
    }

  }
}
