/**
 * Created by wbguan on 2015/8/3.
 */
package {
  import flash.geom.Point;
  import flash.utils.getTimer;

  import model.MObject;
  import model.PlaneElement;

  import starling.animation.IAnimatable;

  import starling.core.Starling;

  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.events.Event;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;

  import util.vector2D.Vector2D;

  public class PlaneDemo extends Sprite implements IAnimatable{
    private var _bg:Quad;
    private var _last:Vector2D ;
    private var _plane:MObject;
    private var _planeElement:PlaneElement;
    public function PlaneDemo() {
      super();
      _plane = new MObject();
      _plane.init({name:"egg",speed:100,mass:5,power:10});
      _planeElement = new PlaneElement(_plane);
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void {
      _bg = new Quad(this.stage.stageWidth,this.stage.stageHeight,0xff123456);
      this.addChild(_bg)
      this.addEventListener(TouchEvent.TOUCH, onTouch);
      this.addChild(_planeElement);

      Starling.juggler.add(this);
    }

    private function checkRage():void{

    }
    var touch:Touch;
    private function onTouch(event:TouchEvent):void {
      touch = event.getTouch(this);
    }

    public function advanceTime(time:Number):void {
      if(touch !=null){

        var c:Vector2D = new Vector2D(touch.globalX,touch.globalY);
        var f:Vector2D = new Vector2D();
        f.x = c.x - _planeElement.x;
        f.y = c.y - _planeElement.y;
        trace("v len "+_plane.v.length);
        if(_plane.v.length>_plane.position.subtract(c).length||_plane.position.subtract(c).length == 0){
          _plane.arrive(c.x,c.y);
        }else {
          _plane.setF(f);
        }
        _planeElement.advanceTime(time);
      }else{
        trace("touch null");
      }
    }
  }
}
