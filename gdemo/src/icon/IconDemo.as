/**
 * Created by wbguan on 2015/3/2.
 */
package icon {
  import flash.display.Bitmap;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.net.URLRequest;
  import flash.utils.Timer;

  import unity.LRButton;

  import unity.LRRectangleRandom;
  import unity.vector2D.movable.MovableSimple;

  public class IconDemo extends Sprite {
    private var _loader:Loader;
    private var _source:Bitmap;
    private var _icons:Vector.<Element>=new Vector.<Element>();
    private var _recR:LRRectangleRandom;
    private var _start:LRButton;
    private var _timer:Timer = new Timer(30);
    private var _target:Point;
    public function IconDemo() {
      super();
      _recR = new LRRectangleRandom(new Rectangle(100,100,500,150),new Rectangle(0,0,43,45));
      _loader=new Loader();
      this._start = new LRButton("start");
      var req:URLRequest = new URLRequest("chip_01.png");
      this.addChild(this._start);
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      this._start.addEventListener(MouseEvent.CLICK, onClick);
      this._timer.addEventListener(TimerEvent.TIMER, onTimer);
      _loader.load(req);
    }

    private function onTimer(event:TimerEvent):void {
      if(_target != null) {
        for each(var ele:Element in this._icons) {
          ele.arrive(this._target);
          ele.update();
        }
      }
    }

    private function onClick(event:MouseEvent):void {
      event.stopPropagation();
      if(this._timer.running){
        this._timer.stop();
        this.stage.removeEventListener(MouseEvent.CLICK, onStageClick);
      }else{
        this._timer.start();
        this.stage.addEventListener(MouseEvent.CLICK, onStageClick);
      }
    }

    private function onStageClick(event:MouseEvent):void {
      _target = new Point(mouseX,mouseY);
    }

    private function onComplete(event:Event):void {
      trace("complete");
      var target:LoaderInfo = event.target as LoaderInfo;
      _source = target.content as Bitmap;
      for(var i:int = 0;i < 1;i++){
        var bit:Bitmap = new Bitmap();
        bit.bitmapData = _source.bitmapData.clone();
        var icon:Element = new Element(bit);
        setLocation(icon);
        this._icons.push(icon);
        this.addChild(icon);
      }
    }

    private function setLocation(ele:Element):void {
      var point:Point = _recR.randomPoint();
      ele.x = point.x;
      ele.y = point.y;
    }
  }
}
