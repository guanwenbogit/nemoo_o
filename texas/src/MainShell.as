/**
 * Created by wbguan on 2015/7/31.
 */
package {
  import flash.display.Sprite;
  import flash.events.Event;

  import starling.core.Starling;

  public class MainShell extends Sprite {
    private var _starling:Starling;
    public function MainShell() {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded)
    }

    private function onAdded(event:Event):void {
      Starling.multitouchEnabled = true;
      _starling = new Starling(Main,this.stage);
      _starling.start();
      _starling.simulateMultitouch = true;
    }

  }
}
