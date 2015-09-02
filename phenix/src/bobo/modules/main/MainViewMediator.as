/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.modules.main {
  import bobo.modules.hud.HudForm;
  import bobo.modules.scene.SceneForm;

  import com.util.layer.Layer;

  import robotlegs.bender.bundles.mvcs.Mediator;

  public class MainViewMediator extends Mediator {
    [Inject]
    public var view:MainView;
    [Inject]
    public var model:RoomModel;
    [Inject]
    public var layer:Layer;
    [Inject]
    public var scene:SceneForm;
    [Inject]
    public var hud:HudForm;

    override public function initialize():void {
      super.initialize();
      initLayer();

    }

    private function initLayer():void{
      layer.addContainer(Layer.BG_LAYER,view.bgContainer);
      layer.addContainer(Layer.SCENE_LAYER,view.sceneContainer);
      layer.addContainer(Layer.HUD_LAYER,view.hudContainer);
      layer.addContainer(Layer.TIPS_LAYER,view.tipContainer);
      layer.addContainer(Layer.COVER_LAYER,view.coverContainer);
      scene.init(view.sceneContainer);
      hud.init(view.hudContainer);
    }

    override public function destroy():void {
      super.destroy();
    }

    public function MainViewMediator() {
      super();
    }
  }
}
