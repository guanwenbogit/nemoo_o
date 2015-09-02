/**
 * Created by wbguan on 2015/9/2.
 */
package bobo.modules.left {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.hud.HudForm;

  import robotlegs.bender.bundles.mvcs.Command;

  public class LeftInitCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var hud:HudForm;

    override public function execute():void {
      super.execute();
      var left:LeftView = new LeftView();
      hud.ui.addChild(left);
    }

    public function LeftInitCmd() {
      super();
    }
  }
}
