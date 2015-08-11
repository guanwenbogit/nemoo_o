/**
 * Created by wbguan on 2015/8/3.
 */
package model {
  import flash.display.Bitmap;

  import starling.animation.IAnimatable;
  import starling.display.Image;
  import starling.display.Quad;
  import starling.display.Sprite;

  import util.ui.shape.LRCircle;

  public class PlaneElement extends Sprite implements IAnimatable {
    [Embed(source = "plane.png")]
    private var Plane:Class;

    private var _core:MObject;


    public function PlaneElement(core:MObject) {
      super();
      _core = core;
      var bitMap:Bitmap = new Plane();
      var img:Image = Image.fromBitmap(bitMap);
      this.addChild(img);

    }

    public function advanceTime(time:Number):void {

      _core.updateV();
      if(!_core.v.isZero()) {
        _core.position.append(_core.v);
      }
//      trace("x " + this.x + " | y " + this.y + " v " + _core.v.length);
      this.x = this._core.position.x;
      this.y = this._core.position.y;
    }
  }
}
