/**
 * Created by wbguan on 2015/8/4.
 */
package tools.imgRect {
  import flash.display.DisplayObject;
  import flash.geom.Point;
  import flash.geom.Rectangle;


  public class ImgRectModel extends Object {
    private var _name:String = "";
    private var _rect:Rectangle;
    private var _register:Point;
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

    public function get register():Point {
      return _register;
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

    public function set register(value:Point):void {
      _register = value;
    }
    public function export():String{
      var result:String = "";
      var obj:Object = {};
      obj["name"] = _name;
      obj["w"] = _rect.width;
      obj["h"] = _rect.height;
      obj["pivotX"] = _register.x;
      obj["pivotY"] = _register.y;
      obj["arr"] = [];
      for each(var c:ImgCircle in this._circles){
        var cOjb:Object = {"r":c.circle.radius,"x":c.x,"y":c.y};
        obj["arr"].push(cOjb);
      }
      result = JSON.stringify(obj);
      return result;
    }
    public function reset():void {
      this._name = "";
      this._rect = new Rectangle();
      this._register = new Point();
      while(_circles.length>0){
        var dis:DisplayObject = _circles.pop();
        if(dis.parent!=null){
          dis.parent.removeChild(dis);
        }
      }
    }
  }
}
