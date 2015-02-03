/**
 * Created by wbguan on 2015/1/30.
 */
package mk.welcome {
  import flash.events.MouseEvent;

  import mk.MKAppConstant;

  import system.api.IData;

  import system.api.IModel;

  import system.api.IScene;
  import system.api.hub.HubPool;
  import system.mould.ViewMould;

  public class WelcomeView extends ViewMould implements IData{
    public function WelcomeView(hubPool:HubPool) {
      super(hubPool);

    }

    override protected function init():void {
      super.init();
    }

    override public function bindScene(scene:IScene):void {
      super.bindScene(scene);
      this._scene.update(null);
      this._scene.container.addEventListener(MouseEvent.CLICK,onClick);
    }

    private function onClick(event:MouseEvent):void {
      this.outside.getHubByName(MKAppConstant.NET_WORK_SEND).publish("login");
    }

    override public function get layout():String {
      return "hud";
    }

    public function bindModel(model:IModel):void {

    }

  }
}
