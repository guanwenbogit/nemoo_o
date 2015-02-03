package unity.layout {
  import unity.*;

  import flash.display.DisplayObjectContainer;

  /**
   * @author wbguan
   */
  public class LayoutManager extends Object {
    private var _parent:DisplayObjectContainer;
    private var _cover:LRContainer;
    private var _alert:LRContainer;
    private var _hud:LRContainer;
    private var _boxes:LRContainer;
    private var _sence:LRContainer;
    private var _bg:LRContainer;
    protected static var _instance:LayoutManager;

    public static function get instance():LayoutManager {
      if (_instance == null) {
        _instance = new LayoutManager();
      }
      return _instance;
    }

    public function LayoutManager() {
    }

    public function init(parent:DisplayObjectContainer):void {
      _parent = parent;
      initContainers();
    }

    protected function initContainers():void {
      _cover = new LRContainer();
      _alert = new LRContainer();
      _hud = new LRContainer();
      _boxes = new LRContainer();
      _sence = new LRContainer();
      _bg = new LRContainer();
      _parent.addChild(_bg);
      _parent.addChild(_sence);
      _parent.addChild(_boxes);
      _parent.addChild(_hud);
      _parent.addChild(_alert);
      _parent.addChild(_cover);
    }

    public function get parent():DisplayObjectContainer {
      return _parent;
    }

    public function get cover():LRContainer {
      return _cover;
    }

    public function get alert():LRContainer {
      return _alert;
    }

    public function get hud():LRContainer {
      return _hud;
    }

    public function get boxes():LRContainer {
      return _boxes;
    }

    public function get sence():LRContainer {
      return _sence;
    }

    public function get bg():LRContainer {
      return _bg;
    }
  }
}
