/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.modules.init {
  import bobo.constants.MessageType;
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.launch.Launcher;
  import bobo.modules.main.RoomModel;
  import bobo.modules.msgCmd.GiftListCmd;
  import bobo.modules.net.MessageSender;
  import bobo.util.net.event.MessageSimpleEvent;

  import com.plugin.log.LogUtil;

  import flash.events.IEventDispatcher;


  import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

  public class DashBoardCmd extends Command {
    [Inject]
    public var launcher:Launcher;
    [Inject]
    public var room:RoomModel;
    [Inject]
    public var event:MessageSimpleEvent;
    [Inject]
    public var dispatcher:IEventDispatcher;
    [Inject]
    public var sender:MessageSender;
    [Inject]
    public var cmdMap:IEventCommandMap;
    override public function execute():void {
      super.execute();
      LogUtil.info(JSON.stringify(event.respBody),"DashBoardCmd",false);
      room.init(event.respBody);
      launcher.setup();
      regMsgConfig();
      requestServer();
    }

    private function regMsgConfig():void {
      cmdMap.map(MessageType.GIFT_LIST).toCommand(GiftListCmd);
    }

    private function requestServer():void{
      sender.giftList();
    }

    public function DashBoardCmd() {
      super();
    }
  }
}
