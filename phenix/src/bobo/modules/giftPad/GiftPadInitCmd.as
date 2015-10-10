/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.giftPad {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.scene.SceneForm;

  import robotlegs.bender.bundles.mvcs.Command;

  public class GiftPadInitCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var scene:SceneForm;
    override public function execute():void {
      super.execute();
      var pad:GiftPadView = new GiftPadView(null,290,270);
      scene.component.addChild(pad);
    }

    public function GiftPadInitCmd() {
      super();
    }
  }
}
