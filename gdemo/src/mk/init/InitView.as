/**
 * Created by wbguan on 2015/1/29.
 */
package mk.init {
  import flash.events.MouseEvent;

  import system.SysConstants;
  import system.api.IData;
  import system.api.IModel;

  import system.api.IScene;
  import system.api.hub.HubPool;
  import system.mould.ViewMould;

  public class InitView extends ViewMould implements IData{
    private var _initScene:InitScene;
    public function InitView(hubPool:HubPool) {
      super(hubPool);
    }

    override public function bindScene(scene:IScene):void {
      super.bindScene(scene);
      _initScene = this._scene as InitScene;
      _initScene.update(null);
      this._initScene.addEventListener(MouseEvent.CLICK,onClick);
    }

    private function onClick(event:MouseEvent):void {
      trace("init remove and welcome");
      this.outside.getHubByName(SysConstants.SYS_ACTION_INIT).publish("welcome");
      this.outside.getHubByName(SysConstants.SYS_ACTION_INIT).publish("net");
      this.outside.getHubByName(SysConstants.SYS_ACTION_INIT).publish("data");
      this._initScene.remove();
    }

    override public function get layout():String {
      return "hud";
    }

    public function bindData(...args):void {
    }

    public function bindModel(model:IModel):void {

    }
  }
}
