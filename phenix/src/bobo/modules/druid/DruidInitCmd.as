/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.modules.druid {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.plugin.PluginPreLoader;
  import bobo.modules.plugin.PluginsCollection;
  import bobo.modules.scene.SceneForm;

  import com.plugin.log.LogUtil;

  import robotlegs.bender.bundles.mvcs.Command;


  /*
   * Please visit the bobo.plugins.Druid Class for detail.
   * */
  public class DruidInitCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var scene:SceneForm;
    [Inject]
    public var plugins:PluginsCollection;

    override public function execute():void {
      super.execute();
      var pre:PluginPreLoader = new PluginPreLoader("druid_plugins.swf", null, 294, 433);
      pre.load();
      scene.component.addChild(pre);
      plugins.append("druid", pre);
      LogUtil.info("scene instance " + scene.bg.name,"DruidInitCmd");
    }

    public function DruidInitCmd() {
      super();
    }
  }
}
