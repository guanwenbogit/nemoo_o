/**
 * Created by wbguan on 2015/3/2.
 */
package unity.vector2D.movable {
  import unity.vector2D.*;
  import flash.events.EventDispatcher;

  public class MovableElement extends MovableObj {
    private var _maxForce:Number = 1;
    private var _steeringForce:Vector2D;
    private var _dispatcher:EventDispatcher;
    private var _internalMaxForce:int = 0;
    public function MovableElement() {
      this._steeringForce = new Vector2D();
      this._dispatcher = new EventDispatcher();
      super();
    }

    public function get maxForce():Number {
      return _maxForce;
    }

    public function set maxForce(value:Number):void {
      _maxForce = value;
    }

    override public function update():void {
      _steeringForce.truncate(_internalMaxForce);
      trace("steeringForce : " +_steeringForce.toString());
      _steeringForce = _steeringForce.divide(_mass);
      _velocity = _velocity.add(_steeringForce);
      _steeringForce = new Vector2D();
      super.update();
    }

    public function seek(target:Vector2D):void{
      var desiredVelocity: Vector2D = target.subtract(_position);
      desiredVelocity.normalize();
      _internalMaxForce = this._maxForce;
      desiredVelocity = desiredVelocity.multiply(_maxSpeed);
      var force:Vector2D = desiredVelocity.subtract(_velocity);
      _steeringForce = _steeringForce.add(force);
    }

    private function dispatchEvent(type:String):void {
      this._dispatcher.dispatchEvent(new MovableElementEvent(type));
    }
    public function flee(target: Vector2D): void {
      var desiredVelocity: Vector2D = target.subtract(_position);
      desiredVelocity.normalize();
      desiredVelocity = desiredVelocity.multiply(_maxSpeed);
      var force: Vector2D = desiredVelocity.subtract(_velocity);
      _steeringForce = _steeringForce.subtract(force);
    }
    private var _arrivalThreshold:Number = 100;
    public function arrive(target: Vector2D): void {
      var desiredVelocity:Vector2D = target.subtract(_position);
      desiredVelocity.normalize();
      _internalMaxForce = this._maxForce;
      var dist:Number = _position.dist(target);
      if (dist > _arrivalThreshold) {
        desiredVelocity = desiredVelocity.multiply(_maxSpeed);
      } else {
        desiredVelocity = desiredVelocity.multiply(_maxSpeed * dist / _arrivalThreshold);
      }
      var force:Vector2D = desiredVelocity.subtract(_velocity);
      _steeringForce = _steeringForce.add(force);
    }
    public function arriveAt(target: Vector2D):void{
      var desiredVelocity:Vector2D = target.subtract(_position);
      desiredVelocity.normalize();
      var dist:Number = _position.dist(target);
      trace("dist len : " + dist);
      if(this._velocity.length < dist){
        desiredVelocity = desiredVelocity.multiply(_maxSpeed);
        _internalMaxForce = this._maxForce;
      }else{
        desiredVelocity.length = dist;
        _internalMaxForce = Math.ceil(desiredVelocity.subtract(_velocity).length);
      }
      trace("dv : " + desiredVelocity.toString()+" len : " +desiredVelocity.length);
      trace("v ： "+_velocity.toString()+" len : "+_velocity.length) ;
      var force:Vector2D = desiredVelocity.subtract(_velocity);
      _steeringForce = _steeringForce.add(force);
    }
    public function get arrivalThreshold():Number {
      return _arrivalThreshold;
    }

    public function set arrivalThreshold(value:Number):void {
      _arrivalThreshold = value;
    }
  }
}
