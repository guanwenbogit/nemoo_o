/**
 * Created by wbguan on 2015/8/21.
 */
package bobo.modules.net {
  import bobo.constants.ActionMessageUtil;
  import bobo.modules.main.RoomModel;
  import bobo.util.app.framework.NetWork;

  public class MessageSender {
    [Inject]
    public var netWork:NetWork;
    [Inject]
    public var room:RoomModel;
    public function enterRoom():void{
      netWork.send(ActionMessageUtil.createEnterRoomMessage(room));
    }
    public function giftList():void{
      netWork.send(ActionMessageUtil.createGiftListMessage());
    }
    public function MessageSender() {
    }
  }
}
