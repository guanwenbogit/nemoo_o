/**
 * Created by wbguan on 2015/8/10.
 */
package model {
  public class VObject {
    private var _pivotX:int = 0;
    private var _pivotY:int = 0;
    protected var _name:String = "";
    protected var _vs:Array = [];
    private var _h:int = 0;
    private var _w:int = 0;
    public function VObject() {
    }
    public function init(data:Object):void{
      _pivotX = data["pivotX"];
      _pivotY = data["pivotY"];
      _name = data["name"];
      _vs = data["arr"];
      _h = data["h"];
      _w = data["w"];
    }

    public function get pivotX():int {
      return _pivotX;
    }

    public function get pivotY():int {
      return _pivotY;
    }

    public function get name():String {
      return _name;
    }

    public function get h():int {
      return _h;
    }


    public function get w():int {
      return _w;
    }

    public function get vs():Array {
      return _vs;
    }
  }
}
