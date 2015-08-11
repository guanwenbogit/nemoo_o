/**
 * Created by wbguan on 15/7/26.
 */
package game {
import org.robotlegs.mvcs.StarlingContext;

import starling.display.Sprite;
import starling.events.Event;

public class MainGame extends starling.display.Sprite {

    public function MainGame() {
      super();
      trace("Main Game");
      this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
      var context:StarlingContext = new MainContext(this);
    }

  private function onAdded(event:Event):void {
     this.addChild(new MainView());
  }
  }
}
