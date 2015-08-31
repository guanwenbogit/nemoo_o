/**
 * Created by wbguan on 2015/8/4.
 */
package tools.imgRect {
  import flash.display.Sprite;

  import com.util.ui.shape.LRCircle;

  public class ImgCircle extends Sprite {
    private var _circle:LRCircle;
    private var _bg:LRCircle;
    public function ImgCircle() {
      super();
    }

    public function setCircle(param:LRCircle):void{
      if(_circle != null&&this.contains(_circle)){
        this.removeChild(_circle);
      }
      if(_bg !=null && this.contains(_bg)){
        this.removeChild(_bg);
      }
      _circle = param;
      _bg = new LRCircle(_circle.radius,0x123456,1);

      this.addChild(_circle);
    }
    public function select():void{
      this.addChildAt(_bg,0);
//      _bg.x = -1;
//      _bg.y = -1;
    }
    public function unSelect():void{
      if(_bg !=null && this.contains(_bg)){
        this.removeChild(_bg);
      }
    }
    public function get circle():LRCircle {
      return _circle;
    }
  }
}
