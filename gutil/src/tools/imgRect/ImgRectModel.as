/**
 * Created by wbguan on 2015/8/4.
 */
package tools.imgRect {
  import flash.geom.Point;
  import flash.geom.Rectangle;

  import util.ui.shape.LRCircle;

  public class ImgRectModel extends Object {
    private var _name:String = "";
    private var _rect:Rectangle;
    private var _center:Point;
    private var _circles:Vector.<ImgCircle> = new <ImgCircle>[];
    public function ImgRectModel() {
      super();
    }

    public function get name():String {
      return _name;
    }

    public function get rect():Rectangle {
      return _rect;
    }

    public function get center():Point {
      return _center;
    }

    public function get circles():Vector.<ImgCircle> {
      return _circles;
    }

    public function set name(value:String):void {
      _name = value;
    }

    public function set rect(value:Rectangle):void {
      _rect = value;
    }

    public function set center(value:Point):void {
      _center = value;
    }
  }
}
