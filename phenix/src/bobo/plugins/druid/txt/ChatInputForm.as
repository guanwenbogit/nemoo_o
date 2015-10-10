/**
 * Created by wbguan on 2015/9/18.
 */
package bobo.plugins.druid.txt {

  import com.util.txt.TextUtil;

  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.text.TextField;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;

  public class ChatInputForm extends Sprite {
    private var _inputTxt:InputTxt;
    private var _bgTxt:TextField;
    private var _inputAcBg:Bitmap;
    private var _inputUnBg:Bitmap;
    private var _org:NOrg;
    public function ChatInputForm() {
      super();
      initInstance();
    }
    private function initInstance():void{
      _org = NProvider.getOrg(ChatConstants.BG_UI);
      _inputTxt = new InputTxt(150,20);
      _inputTxt.init();
      _bgTxt = new TextField();
      _inputAcBg = _org.getBg("chatAc");
      _inputUnBg = _org.getBg("chatUn");
      this.addChild(_inputUnBg);
      this.addChild(_bgTxt);
      this.addChild(_inputTxt);
      _bgTxt.width = 230;
      _bgTxt.height = 20;
      TextUtil.setFormat(_bgTxt,0xffffff,12,false);
      _inputTxt.setFormat(_bgTxt.defaultTextFormat);
      _inputTxt.y = 8;
      _inputTxt.x = 30;
    }

    public function get text():String {
      return _inputTxt.text;
    }
  }
}
