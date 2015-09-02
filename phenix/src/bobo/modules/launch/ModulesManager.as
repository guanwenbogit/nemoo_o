/**
 * Created by wbguan on 2015/8/20.
 */
package bobo.modules.launch {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;

  import com.plugin.log.Log;
  import com.plugin.log.LogUtil;

  import flash.events.IEventDispatcher;

  public class ModulesManager {
    [Inject]
    public var dispatcher:IEventDispatcher;
    [Inject]
    public var launcher:Launcher;
    public function init():void{
      buildInstance();
      launcher.launchSignal.add(onLauncher);
    }
    private function buildInstance():void{
      dispatcher.dispatchEvent(new SimpleEvent(SimpleType.VIDEO_INIT,null));

    }
    private function onLauncher(name:String):void {
      // new all modules instance here
      LogUtil.info(name,"LauncherManager");
      parse(name);
    }

    private function parse(name:String):void {
      dispatcher.dispatchEvent(new SimpleEvent(name,null))
    }

    public function ModulesManager() {
    }

  }
}
