/**
 * Created by wbguan on 2015/8/21.
 */
package bobo.modules.scene {
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;

  public class SceneForm {
    private var _root:DisplayObjectContainer;

    public function get bg():Sprite {
      return _bg;
    }

    public function get video():Sprite {
      return _video;
    }

    public function get component():Sprite {
      return _component;
    }

    public function get animation():Sprite {
      return _animation;
    }

    public function get loft():Sprite {
      return _loft;
    }

    public function get cover():Sprite {
      return _cover;
    }

    private var _bg:Sprite = new Sprite();
    private var _video:Sprite = new Sprite();
    private var _component:Sprite = new Sprite();
    private var _animation:Sprite = new Sprite();
    private var _loft:Sprite = new Sprite();
    private var _cover:Sprite = new Sprite();

    public function init(root:DisplayObjectContainer):void{
      _root = root;
      this._root.addChild(_bg);
      this._root.addChild(_video);
      this._root.addChild(_component);
      this._root.addChild(_animation);
      this._root.addChild(_loft);
      this._root.addChild(_cover);
    }

  }
}
