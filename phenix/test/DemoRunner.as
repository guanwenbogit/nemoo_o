/**
 * Created by wbguan on 2015/9/18.
 */
package {
  import bobo.modules.druid.ChatViewDemo;

  import flash.display.Sprite;
  import flash.display.StageScaleMode;
  import flash.events.Event;

  public class DemoRunner extends Sprite {
    public function DemoRunner() {
      super();
      trace("demo start");
      this.addChild(new ChatViewDemo());
      this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
    }

    private function onAdded(event:Event):void {
      this.stage.scaleMode = StageScaleMode.NO_SCALE;
    }
  }
}
