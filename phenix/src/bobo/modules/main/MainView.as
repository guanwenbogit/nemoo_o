/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.modules.main {
  import flash.display.Sprite;

  public class MainView extends Sprite {
    private var _bgContainer:Sprite = new Sprite();
    private var _sceneContainer:Sprite = new Sprite();
    private var _hudContainer:Sprite = new Sprite();
    private var _tipContainer:Sprite = new Sprite();
    private var _coverContainer:Sprite = new Sprite();

    public function MainView() {
      super();
      init();
    }
    private function init():void{
      this.addChild(_bgContainer);
      this.addChild(_sceneContainer);
      this.addChild(_hudContainer);
      this.addChild(_tipContainer);
      this.addChild(_coverContainer);
    }

    public function get bgContainer():Sprite {
      return _bgContainer;
    }

    public function get sceneContainer():Sprite {
      return _sceneContainer;
    }

    public function get hudContainer():Sprite {
      return _hudContainer;
    }

    public function get tipContainer():Sprite {
      return _tipContainer;
    }

    public function get coverContainer():Sprite {
      return _coverContainer;
    }
  }
}
