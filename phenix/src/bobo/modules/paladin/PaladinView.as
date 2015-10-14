/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.paladin {
  import com.util.ui.list.LRRadioBtnEvent;
  import com.util.ui.list.LRRadioBtnList;
  import com.util.ui.unity.LRRangeContainer;
  import com.util.ui.unity.NButton;
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;

  /*
   * It is the container and parent of Current Rank,Week Rank and MicPanel;
   * */
  public class PaladinView extends PreLoadingView {
    private var _radio:LRRadioBtnList;
    private var _currRankBtn:NButton;
    private var _weekRankBtn:NButton;
    private var _micBtn:NButton;
    private var _bg:DisplayObject;
    private var _org:NOrg;

    public function PaladinView(loading:DisplayObject, w:int, h:int) {
      super(loading, w, h);
      initInstance();
      initListener();
    }

    private function initListener():void {
    }

    public function switchMic():void{

    }

    public function switchRank():void{

    }

    public function initInstance():void {
      _radio = new LRRadioBtnList();
    }

    override public function init():void {
      super.init();
      _org = NProvider.getOrg(PaladinConstants.UI);
      _bg = _org.getBg("paladin");
      _bg.width = _w;
      _bg.height = _h;
      this.addChild(_bg);
      _currRankBtn = _org.getBtn("currRankBtn");
      _weekRankBtn = _org.getBtn("weekRankBtn");
      _micBtn = _org.getBtn("micBtn");
      _radio.appendBtns(_currRankBtn, _weekRankBtn, _micBtn);
      this.addChild(_radio);
      _micBtn.x = 100;
      var range:LRRangeContainer = new LRRangeContainer(_radio,0,LRRangeContainer.RIGHT);
      range.range();
      _bg.y = 32;
    }

  }
}
