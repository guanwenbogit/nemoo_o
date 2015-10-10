/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.plugins.druid.txt {

  import bobo.plugins.druid.txt.info.ChatInfo;

  import com.plugin.richTxt.IRichImgMapping;
  import com.util.ui.scrollbar.LRScrollerList;
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.unity.BaseBtn;
  import com.util.ui.unity.LRButton;


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
    private var _faceBtn:BaseBtn;
    private var _input:ChatInputForm;
    private var _org:NOrg;
    private const H:int = 330;
    public function ChatPanel() {
      super();
    }

    public function init(map:IRichImgMapping):void{
      _org = NProvider.getOrg(ChatConstants.BG_UI);

      _sendBtn = _org.getBtn("sendMsg");
      _flyBtn = _org.getBtn("flyMsg");
      _faceBtn = _org.getBtn("face");
      _btn = new LRButton("bar");
      _barBg = new LRRectangle(10,10,0xffff00);

      _list = new LRScrollerList(ChatElement,280,H,H,_btn,_barBg,0,200,false,map);
      _input = new ChatInputForm();
      this.addChild(_list);
      this.addChild(_input);
      this.addChild(_faceBtn);
      this.addChild(_sendBtn);
      this.addChild(_flyBtn);
      _list.setBarLocation(270,0);
//      _list.checkBar();
      location();
    }
    private function location():void{
      _input.y = H+4;
      _sendBtn.y = H+8;
      _flyBtn.y = H+3;
      _list.x = 30;
      _faceBtn.y = H+8;
      _sendBtn.x = _input.width + _input.x+1;
      _flyBtn.x = _sendBtn.width + _sendBtn.x - 5;
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
