/**
 * Created by wbguan on 2015/3/2.
 */
package icon {
  import flash.display.Bitmap;

  import com.util.vector2D.movable.MovableSimple;
  public class Element extends MovableSimple {
    private var _pic:Bitmap;
    public function Element(pic:Bitmap) {
      super();
      _pic = pic
      this.addChild(this._pic);
      this._movable.maxSpeed = 30;
      trace("================= +=:" +this._movable.maxSpeed);
    }

  }
}
