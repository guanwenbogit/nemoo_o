/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.paladin {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.scene.SceneForm;

  import robotlegs.bender.bundles.mvcs.Command;

  public class PaladinCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var scene:SceneForm;
    override public function execute():void {
      super.execute();
      var paladin:PaladinView = new PaladinView(null,280,196);
      scene.component.addChild(paladin);
    }

    public function PaladinCmd() {
      super();
    }
  }
}
