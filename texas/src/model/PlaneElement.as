/**
 * Created by wbguan on 2015/8/3.
 */
package model {
  import starling.animation.IAnimatable;
  import starling.display.Quad;
  import starling.display.Sprite;

  import util.ui.shape.LRCircle;

  public class PlaneElement extends Sprite implements IAnimatable {
    private var _core:Plane;


    public function PlaneElement(core:Plane) {
      super();
      _core = core;
      this.addChild(new Quad(50, 50, 0xffff0000));
    }

    public function advanceTime(time:Number):void {

      _core.updateV();
      if(!_core.v.isZero()) {
        _core.position.append(_core.v);
      }
      trace("x " + this.x + " | y " + this.y + " v " + _core.v.length);
      this.x = this._core.position.x;
      this.y = this._core.position.y;
    }
  }
}
