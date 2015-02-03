/**
 * Created by wbguan on 2015/1/30.
 */
package system.layout {
  import flash.display.DisplayObjectContainer;

  import system.api.ILayout;
  import system.api.IScene;
  import system.util.container.IContainer;
  import system.util.container.OContainer;

  public class LayoutIScene implements ILayout {
    protected var _root:IContainer;
    protected var _key:Array = [];
    protected var _containers:Vector.<IContainer> = new Vector.<IContainer>();

    public function LayoutIScene(root:Object) {
      this.initRoot(root);
      this.initLayouts();
    }

    protected function initRoot(root:Object):void {

    }

    protected function initLayouts():void {
      trace("WARNNING.Can not new a LayoutIScene instance. Please derive a sub class.")
    }

    public function addScene(layout:String, scene:IScene):void {
      if (scene.container!= null && scene.container.core != null) {
        var i:int = _key.indexOf(layout);
        var c:IContainer;
        if (i >= 0) {
          c = _containers[i];
        } else {
          c = createContainer();
          this._key.push(layout);
          this._containers.push(c);
          this._root.addChild(c.core);
        }
        scene.container.setParent(c);
      }
    }

    protected function createContainer():IContainer {
      return null;
    }

    public function removeScene(scene:IScene):void {

    }

    public function layout():void {

    }
  }
}
