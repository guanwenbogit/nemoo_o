/**
 * Created by wbguan on 2015/8/27.
 */
package bobo.modules.left {

  import com.util.ui.unity.LR9Bitmap;

  import flash.display.Sprite;

  import tools.uiProvider.NProvider;

  public class LeftView extends Sprite {
    private var _head:HeadPanel;
    private var _feature:FeaturePanel;
    private var _link:LinkPanel;
    private var _op:OpPanel;
    private var _bg:LR9Bitmap;

    public function init(url:String):void{
      initInstance(url);
    }

    private function initInstance(url:String):void {
      _bg = NProvider.getOrg(url).getScaleBg("left");
      _head.init(url);
      _feature.init(url);
      _link.init(url);
      this.addChild(_bg);
      this.addChild(_head);
      this.addChild(_feature);
      this.addChild(_link);
      _feature.y = 75;
      _link.y = 410;
      _head.guestMode();
      _bg.height = 1050;
    }
    public function LeftView() {
      super();
      _head = new HeadPanel();
      _feature = new FeaturePanel();
      _link = new LinkPanel();
    }

    public function get head():HeadPanel {
      return _head;
    }

    public function get feature():FeaturePanel {
      return _feature;
    }

    public function get link():LinkPanel {
      return _link;
    }
  }
}
