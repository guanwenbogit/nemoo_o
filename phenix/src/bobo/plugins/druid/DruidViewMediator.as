/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.plugins.druid {

  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.modules.scene.SceneForm;
  import bobo.plugins.druid.txt.ChatConstants;
  import bobo.util.AlignUtil;

  import com.plugin.log.LogUtil;

  import flash.events.IEventDispatcher;


  import flash.geom.Point;

  import robotlegs.bender.bundles.mvcs.Mediator;
  import robotlegs.bender.framework.api.IInjector;

  import tools.uiProvider.NProvider;

  public class DruidViewMediator extends Mediator {
    [Inject]
    public var view:Druid;
    [Inject]
    public var scene:SceneForm;
    [Inject]
    public var injector:IInjector;
    [Inject]
    public var dispatcher:IEventDispatcher;
    override public function initialize():void {
      super.initialize();
      NProvider.loadOrg(ChatConstants.BG_UI,ChatConstants.BG_UI_JSON,onUi);
      LogUtil.info("scene instance " + scene.bg.name,"DruidViewMediator");
      dispatcher.dispatchEvent(new SimpleEvent(SimpleType.LEFT_INIT,null));
    }

    private function onUi(...args):void {
      view.initUI();
      AlignUtil.align(view,AlignUtil.H_CENTER, AlignUtil.V_TOP,new Point(490,30));
    }

    override public function destroy():void {
      super.destroy();
      view.dispose();
    }
  }
}
