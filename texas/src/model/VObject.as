/**
 * Created by wbguan on 2015/8/10.
 */
package model {
  public class VObject {
    private var _pivotX:int = 0;
    private var _pivotY:int = 0;
    protected var _name:String = "";
    private var _vs:Array = [];
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
    public function hitTest(obj:VObject):Boolean{
      var result:Boolean = false;
      for each(var c:Object in obj.vs){
        for each(var subc:Object in this._vs){
          result = isHit(c,subc);
          if(result){
            break;
          }
        }
      }
      return result;
    }

    private function isHit(c1:Object,c2:Object):Boolean{
      var result:Boolean = false;
      var r1:int = c1["r"];
      var r2:int = c2["r"];
      var R:int = (r1+r2)*(r1+r2);
      var D:int = (c1["x"]-c2["x"])*(c1["x"]-c2["x"])+(c1["y"]-c2["y"])*(c1["y"]-c2["y"]);
      result = (D<=R)
      return result;
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
