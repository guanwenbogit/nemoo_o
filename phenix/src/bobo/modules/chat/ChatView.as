/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.modules.chat {
  import com.plugin.richTxt.RichTextField;
  import com.util.ui.unity.LR9Bitmap;
  import com.util.ui.view.PreLoadingView;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;


  public class ChatView extends PreLoadingView {
    private var _bg:LR9Bitmap;
    private var _output:ChatPanel;

    private var _org:NOrg;

    public function ChatView( w:int, h:int) {
      super(null, w, h);
      new RichTextField();
    }

    override public function init():void {
      super.init();
      _org = NProvider.getOrg(ChatConstants.BG_UI);
      _bg = _org.getScaleBg("chatOut");
      _output = new ChatPanel();
      _output.init(null);
      this.addChild(_bg);
      this.addChild(_output);
    }
  }
}
