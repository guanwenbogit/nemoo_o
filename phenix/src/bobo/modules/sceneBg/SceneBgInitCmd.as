/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.modules.sceneBg {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.scene.SceneForm;
  import bobo.util.AlignUtil;

  import com.plugin.log.LogUtil;

  import robotlegs.bender.bundles.mvcs.Command;

  public class SceneBgInitCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var scene:SceneForm;

    override public function execute():void {
      super.execute();
      LogUtil.info("scene ","SceneBgInitCmd");
      var bg:SceneBgView = new SceneBgView(null,1900,1050);
      scene.bg.addChildAt(bg,0);
      bg.init();
      AlignUtil.align(bg,AlignUtil.H_CENTER, AlignUtil.V_TOP);
    }

    public function SceneBgInitCmd() {
      super();
    }
  }
}
