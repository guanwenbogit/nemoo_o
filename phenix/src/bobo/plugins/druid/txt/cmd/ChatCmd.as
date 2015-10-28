/**
 * Created by wbguan on 2015/10/15.
 */
package bobo.plugins.druid.txt.cmd {
  import bobo.constants.MessageType;
  import bobo.modules.user.ISelfInfo;
  import bobo.plugins.druid.txt.ChatModel;
  import bobo.util.net.event.MessageSimpleEvent;

  import robotlegs.bender.bundles.mvcs.Command;

  public class ChatCmd extends Command {
    [Inject]
    public var event:MessageSimpleEvent;
    [Inject]
    public var chatModel:ChatModel;
    [Inject]
    public var self:ISelfInfo;
    override public function execute():void {
      super.execute();
      if(event.type == MessageType.RESP_GROUP_CHAT_MSG){
        var list:Array = event.respBody["list"] as Array;
        list = list.filter(filterOutSelfPublish);
        var param:Array = [];
        for each(var obj:Object in list){
          param.push(obj["body"]);
        }
        chatModel.appendPublishArr(list);
      }else if(event.type == MessageType.WHISPER || event.type == MessageType.WHISPER_MSG){
        chatModel.appendWhisperArr([event.respBody]);
      }

    }
    private function filterOutSelfPublish(item:*, index:int, array:Array):Boolean{
      var result:Boolean;
      result = !checkHeaderIgnore(item["header"],self.userId);
      return result;
    }
    public static function checkHeaderIgnore(header:Object,selfId:String):Boolean{
      var result:Boolean;
      var ignore:Boolean = Boolean(header["ignoreSource"]);
      var source:String = String(header["source"]);
      if(ignore && source == selfId){
        result = true;
      }
      return result;
    }

    public function ChatCmd() {
      super();
    }
  }
}
