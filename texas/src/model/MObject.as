/**
 * Created by wbguan on 2015/8/3.
 */
package model {
  import util.vector2D.Vector2D;

  public class MObject extends VObject{

    private var _mass:int = 1;
    private var _speed:int = 1;
    private var _power:int = 1;
    private var _position:Vector2D;
    private var _v:Vector2D;
    private var _f:Vector2D;
    private var _a:Vector2D;
    public function MObject() {
      initInstance();
    }

    private function initInstance():void{
      _position = new Vector2D();
      _v = new Vector2D();
      _a = new Vector2D();
      _f = new Vector2D();
    }

    override public function init(obj:Object):void{
      super.init(obj);
      _mass = obj["mass"];
      _speed = obj["speed"];
      _power = obj["power"];
    }
    public function arrive(x:int ,y:int):void{
      _position.x = x;
      _position.y = y;
      _f.x = 0;
      _f.y = 0;
      _a.x = 0;
      _a.y = 0;
      _v.x = 0;
      _v.y = 0;
    }
    public function setF(param:Vector2D):void{
      param.length = _power;
      var tmp:Number = _v.length;
      _v.x = param.x;
      _v.y = param.y;
      _v.length = tmp;
      _f.x = param.x;
      _f.y = param.y;
      _a.x = _f.x;
      _a.y = _f.y;
      _a.length = _power/_mass;
    }
    public function updateV():void{
      if(!_a.isZero()) {
//        trace("update v ");
        _v.append(_a);
        if(_v.length>_speed){
          _v.length = _speed;
        }
      }
    }
    public function hitTest(obj:MObject):Boolean{
      var result:Boolean = false;
      for each(var c:Object in obj.vs){
        for each(var subc:Object in this._vs){
          result = isHit(c,subc,obj);
          if(result){
            break;
          }
        }
      }
      return result;
    }

    private function isHit(c1:Object, c2:Object, obj1:MObject):Boolean{
      var result:Boolean = false;
      var r1:int = c1["r"];
      var r2:int = c2["r"];
      var R:int = (r1+r2)*(r1+r2);
      var X:int = (c1["x"]+obj1.position.x-c2["x"]-this.position.x);
      var Y:int = (c1["y"]+obj1.position.y-c2["y"]-this.position.y);
      var D:int = X*X+Y*Y;
      result = (D<=R)
      return result;
    }
    public function get mass():int {
      return _mass;
    }

    public function get speed():int {
      return _speed;
    }

    public function get power():int {
      return _power;
    }

    public function get position():Vector2D {
      return _position;
    }

    public function get v():Vector2D {
      return _v;
    }

    public function get f():Vector2D {
      return _f;
    }

    public function get a():Vector2D {
      return _a;
    }
  }
}
