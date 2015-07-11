/**
 * Created by wbguan on 2015/3/2.
 */
package unity.vector2D.movable {
  import flash.display.Sprite;
  import flash.geom.Point;

  import unity.vector2D.Vector2D;

  public class MovableSimple extends Sprite {
    protected var _movable:MovableElement;

    public function MovableSimple() {
      super();
      this._movable = new MovableElement();
    }

    public function update():void{
      this._movable.update();
      this.x = this._movable.position.x;
      this.y = this._movable.position.y;
//      rotation = this._movable.velocity.angle * 180 / Math.PI;
    }


    override public function set x(value:Number):void {
      super.x = value;
      this._movable.position.x = value;
    }

    override public function set y(value:Number):void {
      super.y = value;
      this._movable.position.y = value;
    }

    public function seek(point:Point):void{
      var target:Vector2D = new Vector2D(point.x,point.y);
      this._movable.seek(target);
    }

    public function arrive(point:Point):void{
      var target:Vector2D = new Vector2D(point.x,point.y);
      this._movable.arriveAt(target);
    }
    public function isArrive(point:Point):Boolean{
      var result:Boolean;
      var target:Vector2D = new Vector2D(point.x,point.y);
      result = (this._movable.position.dist(target)<1);
      return result;
    }
  }
}
