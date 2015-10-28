/**
 * Created by wbguan on 2015/10/15.
 */
package bobo.plugins.druid.txt {
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.room.IRoom;
  import bobo.modules.user.IAnchorInfo;
  import bobo.modules.user.ISelfInfo;
  import bobo.modules.user.UserInfoModel;
  import bobo.plugins.druid.txt.info.ChatInfo;

  import flash.events.IEventDispatcher;
  import flash.text.TextFormat;

  public class ChatModel extends Object {
    [Inject]
    public var dispatcher:IEventDispatcher;
    [Inject]
    public var self:ISelfInfo;
    [Inject]
    public var anchor:IAnchorInfo;
    [Inject]
    public var room:IRoom;

    private var _publishArr:Array = [];
    private var _whisperArr:Array = [];

    public function ChatModel() {
      super();
    }

    public function publishSimpleContent(content:String,
                                         tf:TextFormat,
                                         bg:String,type:String,
                                         sender:UserInfoModel,
                                         atUser:UserInfoModel):void{
      var obj:Object = {"message":content,"tf":tf,"bg":bg,"type":type,"sender":sender,"atUser":atUser};
      appendPublish([obj]);
    }
    private function appendPublish(arr:Array):void{
      _publishArr.concat(arr);
      var param:Object = getInfoFromObj(arr);
      dispatcher.dispatchEvent(new SimpleEvent(ChatModelEventType.APPEND_PUBLISH_ARR, param));
    }

    public function appendPublishArr(arr:Array):void {
      var param:Array = [];
      for each(var obj:Object in arr){
        param.push(obj["body"]);
      }
      appendPublish(param);
    }

    public function appendWhisperArr(arr:Array):void {
      _whisperArr.concat(arr);
      var param:Object = getInfoFromObj(arr);
      dispatcher.dispatchEvent(new SimpleEvent(ChatModelEventType.APPEND_WHISPER_ARR, param));
    }

    private function getInfoFromObj(arr:Array):Vector.<ChatInfo> {
      var result:Vector.<ChatInfo> = new Vector.<ChatInfo>();
      if(arr != null && arr.length>0) {
        result = getLastInfo(arr, arr.length);
      }
      return result;
    }

    private function getLastInfo(arr:Array,last:int):Vector.<ChatInfo> {
      var result:Vector.<ChatInfo> = new Vector.<ChatInfo>();
      last = last < 0 ? 0 : last;
      if(arr != null){
        var len:int = arr.length;
        var start:int = last > len ? len : (len-last);
        for (;start < len; start++) {
          var obj:Object = arr[start];
          var info:ChatInfo = new ChatInfo();
          parseObjToInfo(obj, info);
          result.push(info);
        }
      }
      return result;
    }

    public function getLastWhisper(last:int):Vector.<ChatInfo> {
      var result:Vector.<ChatInfo> = new Vector.<ChatInfo>();
      result = getLastInfo(_whisperArr,last);
      return result;
    }

    public function getLastPublish(last:int):Vector.<ChatInfo> {
      var result:Vector.<ChatInfo> = new Vector.<ChatInfo>();
      result = getLastInfo(_publishArr,last);
      return result;
    }

    private function parseObjToInfo(obj:Object, info:ChatInfo):void {

      var content:String = obj["message"];
      var sender:Object = obj["senderUser"];
      var target:Object = obj["atUser"];
      info.content = content;
      if(sender != null){
        info.from = new UserInfoModel(obj);
      }
      if(target != null){
        info.to = new UserInfoModel(obj);
      }
      var tf:TextFormat = obj["tf"];
      if(tf == null && sender!=null){

      }
      var bg:String = obj["bg"];
      if(sender!=null){

      }else{

      }

    }

  }
}
