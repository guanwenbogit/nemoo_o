/**
 * Created by wbguan on 2015/1/30.
 */
package system.layout.sub {
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;

  import system.layout.LayoutIScene;
  import system.util.container.IContainer;
  import system.util.container.OContainer;

  public class OLayout extends LayoutIScene{
    protected var core:DisplayObjectContainer;
    public function OLayout(root:DisplayObjectContainer) {
      super(root);
    }

    override protected function initRoot(root:Object):void {
      super.initRoot(root);
      this._root = new OContainer(root as DisplayObjectContainer);
    }

    override protected function initLayouts():void {
      super.initLayouts();
    }

    override protected function createContainer():IContainer {
      return new OContainer(new Sprite());
    }

    override public function layout():void {
      super.layout();
    }
  }
}
