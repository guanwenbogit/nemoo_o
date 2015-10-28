/**
 * Created by wbguan on 2015/10/16.
 */
package bobo.plugins.druid.txt {
  import bobo.plugins.druid.txt.info.ChatInfo;

  import com.plugin.richTxt.IRichImgMapping;

  public class ChatElementBuilder {
    [Inject]
    public var richMap:IRichImgMapping;

    public function ChatElementBuilder() {
    }

    public function getEle(chatInfo:ChatInfo):ChatElement{
      var result:ChatElement;
      switch (chatInfo.type){
        case "whisper":
          break;
        case "publish":
          break;
        default:
          result = new ChatElement([richMap]);
          break;
      }
      if(result!=null){
        result.setData(chatInfo);
      }
      return result;
    }

    public function getElements(infos:Vector.<ChatInfo>):Array{
      var result:Array = [];
      for each(var info:ChatInfo in infos){
        result.push(getEle(info));
      }
      return result;
    }

  }
}
