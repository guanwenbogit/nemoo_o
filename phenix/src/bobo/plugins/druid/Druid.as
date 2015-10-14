/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.plugins.druid {

  import bobo.modules.fans.FansPanel;
  import bobo.modules.vod.VodPanel;
  import bobo.plugins.base.BasePlugins;
  import bobo.plugins.druid.txt.ChatConstants;
  import bobo.plugins.druid.txt.ChatPanel;

  import com.util.ui.list.LRRadioBtnEvent;

  import com.util.ui.list.LRRadioBtnList;
  import com.util.ui.unity.LRContainer;
  import com.util.ui.unity.LRRangeContainer;
  import com.util.ui.unity.NButton;


  import flash.display.DisplayObject;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;

  /*
   * It is the container and parent of the ChatPanel,VodPanel and FansPanel
   * */
  public class Druid extends BasePlugins {
    private var _bg:DisplayObject;
    private var _chatPanel:ChatPanel;
    private var _vodPanel:VodPanel;
    private var _fansPanel:FansPanel;

    private var _org:NOrg;
    private var _w:int = 294;
    private var _h:int = 433;
    private var _radio:LRRadioBtnList;
    private var _chatBtn:NButton;
    private var _vodBtn:NButton;
    private var _fansBtn:NButton;
    private var _current:DisplayObject;

    public function Druid() {
      super();
      configs = [DruidConfig];
      initInstance();
      initListener();
    }

    private function initListener():void {
      _radio.addEventListener(LRRadioBtnEvent.CHANGE_EVENT, onChange)
    }

    private function onChange(event:LRRadioBtnEvent):void {
      var i:int = int(event.data);
      if (i == 0) {
        switchChat()
      } else if (i == 1) {
        switchVod();
      } else if (i == 2) {
        switchFans();
      }
    }

    private function setCurrent(param:DisplayObject):void {
      if (_current != null && this.contains(_current)) {
        this.removeChild(_current);
      }
      _current = param;
      this.addChild(_current);
    }

    private function switchChat():void {
      if (_chatPanel == null) {
        _chatPanel = new ChatPanel();
        _chatPanel.y = 77;
      }
      setCurrent(_chatPanel);
    }

    private function switchVod():void {
      if (_vodPanel == null) {
        _vodPanel = new VodPanel(null, _w, _h);
        _vodPanel.y = 77;
      }
      setCurrent(_vodPanel);
    }

    private function switchFans():void {
      if (_fansPanel == null) {
        _fansPanel = new FansPanel(null, _w, _h);
        _fansPanel.y = 77;
      }
      setCurrent(_fansPanel);
    }

    private function initInstance():void {
      _radio = new LRRadioBtnList();
      this.addChild(_radio);
    }

    private function appendRadio():void {
      _radio.appendBtns(_chatBtn, _vodBtn, _fansBtn);
      var range:LRRangeContainer = new LRRangeContainer(_radio, 0, LRContainer.RIGHT);
      range.range();
      _radio.x = 13;
      _radio.setCurrent(0);
    }

    override public function init(...args):void {
      super.init.apply(this,args);
    }

    public function initUI():void {
      _org = NProvider.getOrg(ChatConstants.BG_UI);
      _chatBtn = _org.getBtn("chatLv0");
      _vodBtn = _org.getBtn("vod");
      _fansBtn = _org.getBtn("fans");
      _bg = _org.getScaleBg("chatOut");
      _bg.width = _w;
      _bg.height = _h;
      this.addChildAt(_bg, 0);
      _bg.x = 13;
      _bg.y = 32;
      appendRadio();
    }


  }
}
