/**
 * Created by wbguan on 2015/3/2.
 */
package unity.vector2D.movable {
  import unity.vector2D.*;
  public class MovableObj extends Object {

    protected var _position:Vector2D;
    protected var _velocity:Vector2D;
    protected var _mass:Number = 1.0;
    protected var _maxSpeed:Number = 10;

    public function MovableObj() {
      super();
      this._position = new Vector2D();
      this._velocity = new Vector2D();
    }
    public function update():void{
      _velocity.truncate(_maxSpeed);
      _position = this._position.add(this._velocity);
      trace("MovableObj v ： "+_velocity.toString()+" len : "+_velocity.length) ;
    }

    public function get mass():Number {
      return _mass;
    }

    public function set mass(value:Number):void {
      _mass = value;
    }

    public function get velocity():Vector2D {
      return _velocity;
    }

    public function set velocity(value:Vector2D):void {
      _velocity = value;
    }

    public function get maxSpeed():Number {
      return _maxSpeed;
    }

    public function set maxSpeed(value:Number):void {
      _maxSpeed = value;
    }

    public function get position():Vector2D {
      return _position;
    }

    public function set position(value:Vector2D):void {
      _position = value;
    }
  }
}
