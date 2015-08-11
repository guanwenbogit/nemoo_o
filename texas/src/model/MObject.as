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
        trace("update v ");
        _v.append(_a);
        if(_v.length>_speed){
          _v.length = _speed;
        }
      }
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
