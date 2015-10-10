/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.msgCmd {
  import bobo.constants.MessageType;
  import bobo.modules.gift.GiftConfig;
  import bobo.modules.gift.cmd.SendGiftCmd;
  import bobo.util.net.event.MessageSimpleEvent;

  import robotlegs.bender.bundles.mvcs.Command;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

  public class GiftListCmd extends Command {
    [Inject]
    public var event:MessageSimpleEvent;
    [Inject]
    public var cmdMap:IEventCommandMap;
    override public function execute():void {
      super.execute();
      GiftConfig.init(event.respBody);
      regCmd();
    }

    private function regCmd():void {
      cmdMap.map(MessageType.SEND_GIFT).toCommand(SendGiftCmd);
      cmdMap.map(MessageType.SEND_ANCHOR_GIFT_MSG).toCommand(SendGiftCmd);
      cmdMap.map(MessageType.SEND_USER_GIFT_MSG).toCommand(SendGiftCmd);
    }

    public function GiftListCmd() {
      super();
    }
  }
}
