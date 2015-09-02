/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.modules.init {
  import bobo.modules.launch.Launcher;
  import bobo.modules.main.RoomModel;
  import bobo.util.net.event.MessageSimpleEvent;

  import com.plugin.log.LogUtil;


  import robotlegs.bender.bundles.mvcs.Command;

  public class DashBoardCmd extends Command {
    [Inject]
    public var launcher:Launcher;
    [Inject]
    public var room:RoomModel;
    [Inject]
    public var event:MessageSimpleEvent;
    override public function execute():void {
      super.execute();
      LogUtil.info(JSON.stringify(event.respBody),"DashBoardCmd",false);
      room.init(event.respBody);
      launcher.setup();
    }

    public function DashBoardCmd() {
      super();
    }
  }
}
