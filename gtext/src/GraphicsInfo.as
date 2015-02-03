/**
 * Created by wbguan on 2015/1/22.
 */
package {
  import flash.display.DisplayObject;

  public class GraphicsInfo {
    private var _key:String = "";
    private var _w:int = 1;
    private var _h:int = 1;
    private var _url:String = "";
    private var _g:DisplayObject;
    private var _color:int = -1;
    public function GraphicsInfo() {
    }
    public function get url():String {
      return _url;
    }

    public function set url(value:String):void {
      _url = value;
    }

    public function get key():String {
      return _key;
    }

    public function set key(value:String):void {
      _key = value;
    }

    public function get w():int {
      return _w;
    }

    public function set w(value:int):void {
      _w = value;
    }

    public function get g():DisplayObject {
      return _g;
    }

    public function set g(value:DisplayObject):void {
      _g = value;
    }

    public function get h():int {
      return _h;
    }

    public function set h(value:int):void {
      _h = value;
    }

    public function get color():int {
      return _color;
    }

    public function set color(value:int):void {
      _color = value;
    }
  }
}
