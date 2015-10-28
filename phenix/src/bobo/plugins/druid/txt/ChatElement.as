/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.plugins.druid.txt {
  import bobo.plugins.druid.txt.info.ChatInfo;

  import com.plugin.richTxt.IRichElement;

  import com.plugin.richTxt.IRichImgMapping;

  import com.util.ui.scrollbar.LRScrollerElement;
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.unity.LR9Bitmap;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;


  public class ChatElement extends LRScrollerElement {
    private var _txt:OutputTxt;
    private var _bg:LR9Bitmap;
    private var _info:ChatInfo;
    private var _mapping:IRichImgMapping;
    public function ChatElement(params:Array=null) {
      if(params!=null) {
        _mapping = params[0];
      }
      super();
      initInstance();

    }

    private function initInstance():void {
      _txt = new OutputTxt(300,50);
      _txt.init();
      _txt.setMapping(_mapping);
      this.addChild(_txt);
    }

    override protected function bind():void {
      _info = this.data as ChatInfo;
      if(_info != null){
        render();
      }
    }

    override public function clear():void {
      clearBg();
      clearContent();
    }

    private function clearContent():void {
      if(_txt!=null){
        _txt.clearTxt();
      }
    }

    private function clearBg():void {
      if(_bg !=null && this.contains(_bg)){
        this.removeChild(_bg);
      }
      _bg = null;
    }

    private function render():void {
      renderContent();
      renderBg();
    }

    private function renderContent():void {
      var irich:IRichElement = _txt.core.getGraphics(new LRRectangle(20,20),"id");
      var s:IRichElement = _txt.core.getSpan(_info.content,"s");

      var arr:Vector.<IRichElement>= new <IRichElement>[irich];
      _txt.appendParagraph(arr);
      _txt.appendTxt(_info.content);
      _txt.render();
    }

    private function renderBg():void {
      var org:NOrg = NProvider.getOrg(ChatConstants.BG_UI);
      _bg = org.getScaleBg(_info.bgName);
      if(_bg!=null){
        _txt.x = _bg.left;
        _txt.y = _bg.top;
        _bg.resizeCenter(_txt.width,_txt.height);
        this.addChildAt(_bg,0);
      }
    }

  }
}
