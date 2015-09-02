/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.config {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.modules.left.LeftInitCmd;
  import bobo.modules.video.VideoInitCmd;


  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.framework.api.IConfig;

  public class ModulesConfig implements IConfig {
    [Inject]
    public var cmdMap:IEventCommandMap;
    public function ModulesConfig() {
    }

    public function configure():void {
      cmdMap.map(SimpleType.VIDEO_INIT,SimpleEvent).toCommand(VideoInitCmd);
      cmdMap.map(SimpleType.LEFT_INIT,SimpleEvent).toCommand(LeftInitCmd);
    }
  }
}
