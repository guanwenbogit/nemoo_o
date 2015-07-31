package util.ui.bitmapSheet {
  import flash.geom.Point;
  /**
   * @author wbguan
   */
  public class Frame extends Object {
   private var _data:Object;
    //----------------------------------
    //  w
    //----------------------------------
    private var _w:int;
    public function get w():int {
      return _w;
    }
    //----------------------------------
    //  h
    //----------------------------------
    private var _h:int;
    public function get h():int {
      return _h;
    }
    //----------------------------------
    //  x
    //----------------------------------
    private var _x:int;
    public function get x():int {
      return _x;
    }
    //----------------------------------
    //  y
    //----------------------------------
    private var _y:int;
    public function get y():int {
      return _y;
    }
    //----------------------------------
    //  name
    //----------------------------------
    private var _name:String;
    public function get name():String {
      return _name;
    }
    private var _rotated:Boolean = false;
    private var _spriteSourceSize:Point;
    public function Frame(data:Object) {
      this._data = data;
      this._name = this._data["filename"];
      this._x = int(this._data["frame"]["x"]);
      this._y = int(this._data["frame"]["y"]);
      this._w = int(this._data["frame"]["w"]);
      this._h = int(this._data["frame"]["h"]);
      this._rotated = Boolean(this._data["rotated"]);
      this._spriteSourceSize = new Point(this._data["spriteSourceSize"]["x"],this._data["spriteSourceSize"]["y"]);
    }

    public function get spriteSourceSize() : Point {
      return _spriteSourceSize;
    }

    public function get rotated():Boolean {
      return _rotated;
    }
  }
}
