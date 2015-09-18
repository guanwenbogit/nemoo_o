/**
 * Created by wbguan on 2015/8/31.
 */
package bobo.modules.hud {
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;

  public class HudForm {
    private var _box:Sprite = new Sprite();
    private var _ui:Sprite = new Sprite();
    private var _root:DisplayObjectContainer;
    public function HudForm() {
    }

    public function init(root:DisplayObjectContainer):void {
      _root = root;
      this._root.addChild(_box);
      this._root.addChild(_ui);
    }

    public function get box():Sprite {
      return _box;
    }

    public function get ui():Sprite {
      return _ui;
    }
  }
}
