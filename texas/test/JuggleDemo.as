/**
 * Created by wbguan on 2015/7/30.
 */
package {
  import starling.animation.Juggler;
  import starling.animation.Transitions;
  import starling.animation.Tween;
  import starling.display.Quad;
  import starling.display.Sprite;
  import starling.events.EnterFrameEvent;

  public class JuggleDemo extends Sprite {
    private var jugg1:Juggler;
    private var jugg2:Juggler;
    private var _q:Quad;
    public function JuggleDemo() {
      super();
      this.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnter)
      initInstance();
    }

    private function onEnter(event:EnterFrameEvent):void {
      jugg1.advanceTime(event.passedTime);
    }
    private function initInstance():void{
      jugg1 = new Juggler();
      jugg2 = new Juggler();
      _q = new Quad(50,50,0xccffcc);
      var tw:Tween = new Tween(_q,10,Transitions.EASE_IN_OUT);
      tw.moveTo(200,200);

      this.addChild(_q);
      jugg1.add(tw);
    }
  }
}
