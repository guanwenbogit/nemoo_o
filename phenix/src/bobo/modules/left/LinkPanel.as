/**
 * Created by wbguan on 2015/9/1.
 */
package bobo.modules.left {
  import com.util.ui.unity.BaseBtn;
  import com.util.ui.unity.LRRangeContainer;

  import flash.display.Bitmap;

  import flash.display.Sprite;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;

  public class LinkPanel extends Sprite {
    private var _qa:BaseBtn;
    private var _downLoad:BaseBtn;
    private var _reward:BaseBtn;
    private var _report:BaseBtn;
    private var _org:NOrg;
    private var _line:Bitmap;

    public function LinkPanel() {
      super();
    }

    public function init(url:String):void{
      _org = NProvider.getOrg(url);
      if(_org != null){
        _qa = _org.getBtn("qa");
        _downLoad = _org.getBtn("downLoad");
        _reward = _org.getBtn("reward");
        _report = _org.getBtn("report");
        _line = _org.getBg("line");
        _qa.y = 46;
        this.addChild(_qa);
        this.addChild(_downLoad);
        this.addChild(_reward);
        this.addChild(_report);
        var range:LRRangeContainer = new LRRangeContainer(this,0);
        range.range();
        this.addChild(_line);
      }

    }

    public function get qa():BaseBtn {
      return _qa;
    }

    public function get downLoad():BaseBtn {
      return _downLoad;
    }

    public function get reward():BaseBtn {
      return _reward;
    }

    public function get report():BaseBtn {
      return _report;
    }
  }
}
