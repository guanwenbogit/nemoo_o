/**
 * Created by wbguan on 2015/7/30.
 */
package {
  import flash.display.Sprite;
  import flash.events.Event;

  import starling.core.Starling;

  public class DemoRunner extends Sprite {
    private var starling:Starling;
    public function DemoRunner() {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);

    }

    private function onAdded(event:Event):void {
      Starling.multitouchEnabled = true;
      starling = new Starling(Demo,this.stage);
      starling.start();
      starling.simulateMultitouch = true;
    }
  }
}
