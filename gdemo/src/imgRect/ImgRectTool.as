/**
 * Created by wbguan on 2015/8/4.
 */
package imgRect {
  import flash.display.Sprite;

  import tools.imgRect.ImgRect;

  public class ImgRectTool extends Sprite {
    public function ImgRectTool() {
      super();
      this.addChild(new ImgRect());
    }
  }
}
