/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.paladin {
  import bobo.util.AlignUtil;

  import com.plugin.log.LogUtil;
  import com.util.ui.list.LRRadioBtnEvent;

  import flash.geom.Point;

  import robotlegs.bender.bundles.mvcs.Mediator;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;

  public class PaladinMediator extends Mediator {
    [Inject]
    public var view:PaladinView;

    override public function initialize():void {
      super.initialize();
      NProvider.loadOrg(PaladinConstants.UI,PaladinConstants.UI_JSON,onLoaded)
      view.addEventListener(LRRadioBtnEvent.CHANGE_EVENT,onChange);
      AlignUtil.align(view,AlignUtil.H_CENTER, AlignUtil.V_TOP,new Point(-475,30));
    }

    private function onLoaded(org:NOrg):void {
      if(org.success) {
        view.init();
      }else{
        LogUtil.error("no org :"+org.success,"PaladinMediator");
      }
    }

    private function onChange(event:LRRadioBtnEvent):void {
      var index:int = int(event.data);
      if(index == 0){
        view.switchRank();
      }else if(index == 1){
        view.switchRank();
      }else if(index == 2){
        view.switchMic();
      }
    }

    public function PaladinMediator() {
      super();
    }
  }
}
