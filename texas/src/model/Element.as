/**
 * Created by wbguan on 2015/8/11.
 */
package model {
  import starling.animation.IAnimatable;
  import starling.display.Sprite;

  public class Element extends Sprite implements IAnimatable{
    private var _mobj:MObject;

    public function Element(mobj:MObject) {
      super();
      this._mobj = mobj
    }

    public function advanceTime(time:Number):void {
    }
  }
}
