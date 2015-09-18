/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.modules.chat {
  import bobo.modules.chat.info.ChatInfo;

  import com.plugin.richTxt.IRichImgMapping;
  import com.util.ui.scrollbar.LRScrollerList;
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.unity.BaseBtn;
  import com.util.ui.unity.LRButton;

  import flash.display.Bitmap;

  import flash.display.DisplayObject;

  import flash.display.Sprite;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;

  public class ChatPanel extends Sprite {
    private var _list:LRScrollerList;
    private var _btn:BaseBtn;
    private var _barBg:DisplayObject;
    private var _sendBtn:BaseBtn;

    private var _flyBtn:BaseBtn;
    private var _input:ChatInputForm;
    private var _org:NOrg;
    public function ChatPanel() {
      super();
    }

    public function init(map:IRichImgMapping):void{
      _org = NProvider.getOrg(ChatConstants.BG_UI);

      _sendBtn = _org.getBtn("sendMsg");
      _flyBtn = _org.getBtn("flgMsg");

      _btn = new LRButton("");
      _barBg = new LRRectangle(10,10,0xffffff);

      _list = new LRScrollerList(ChatElement,280,275,275,_btn,_barBg,0,200,false,map);
      _input = new ChatInputForm();
      this.addChild(_list);
      this.addChild(_input);
      this.addChild(_sendBtn);
      this.addChild(_flyBtn);
    }

    public function append(arr:Vector.<ChatInfo>):void{
      _list.appendData(arr);
    }
    public function get text():String{
      return _input.text;
    }
    public function get sendBtn():BaseBtn {
      return _sendBtn;
    }

    public function get flyBtn():BaseBtn {
      return _flyBtn;
    }
  }
}
