/**
 * Created by wbguan on 2015/1/29.
 */
package system.mould {
  import system.api.hub.HubPool;
  import system.api.IScene;
  import system.api.IView;

  public class ViewMould extends Mould implements IView{
    protected var _scene:IScene;
    public function ViewMould(hubPool:HubPool) {
      super(hubPool);
    }

    public function bindScene(scene:IScene):void {
      this._scene = scene;
    }

    public function get scene():IScene {
      return _scene;
    }

    public function get layout():String {
      return "";
    }
  }
}
