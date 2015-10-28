/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.giftPad {
  import com.util.AlignUtil;

  import flash.display.Loader;
  import flash.geom.Point;

  import robotlegs.bender.bundles.mvcs.Mediator;

  import tools.uiProvider.NProvider;

  public class GiftPadMediator extends Mediator {
    [Inject]
    public var view:GiftPadView;

    override public function initialize():void {
      super.initialize();
      NProvider.loadSwf("n_giftPad.swf",onLoaded);
    }

    private function onLoaded(loader:Loader):void {
      view.init();
      AlignUtil.align(view,AlignUtil.H_CENTER, AlignUtil.V_TOP,new Point(-470,260));
    }

    public function GiftPadMediator() {
      super();
    }
  }
}
