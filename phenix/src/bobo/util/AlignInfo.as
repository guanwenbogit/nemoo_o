/**
 * Created by wbguan on 2015/8/26.
 */
package bobo.util {
  import flash.display.DisplayObject;
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class AlignInfo extends Object {
    private var _target:DisplayObject;
    private var _h:String = "";
    private var _v:String = "";
    private var _offset:Point = new Point();
    public function AlignInfo() {
      super();
    }

    public function get target():DisplayObject {
      return _target;
    }

    public function set target(value:DisplayObject):void {
      _target = value;
    }

    public function get h():String {
      return _h;
    }

    public function set h(value:String):void {
      _h = value;
    }

    public function get v():String {
      return _v;
    }

    public function set v(value:String):void {
      _v = value;
    }

    public function get offset():Point {
      return _offset;
    }

    public function set offset(value:Point):void {
      _offset = value;
    }
  }
}
