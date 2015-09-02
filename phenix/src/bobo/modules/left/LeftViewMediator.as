/**
 * Created by wbguan on 2015/8/31.
 */
package bobo.modules.left {

  import flash.events.MouseEvent;

  import robotlegs.bender.bundles.mvcs.Mediator;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;


  public class LeftViewMediator extends Mediator {
    [Inject]
    public var view:LeftView;

    override public function initialize():void {
      super.initialize();
      NProvider.loadOrg("n_left.png","n_left.json",onLoaded);
    }

    private function onLoaded(org:NOrg):void {
      view.init("n_left.png");
      view.link.downLoad.addEventListener(MouseEvent.CLICK, onLinkDownLoad);
      view.link.reward.addEventListener(MouseEvent.CLICK, onLinkReward);
      view.link.report.addEventListener(MouseEvent.CLICK, onLinkReport);
      view.link.qa.addEventListener(MouseEvent.CLICK, onLinkQA);

      view.head.loginBtn.addEventListener(MouseEvent.CLICK, onHeadLogin);
      view.head.regBtn.addEventListener(MouseEvent.CLICK, onHeadReg);
    }

    private function onHeadLogin(event:MouseEvent):void {

    }

    private function onHeadReg(event:MouseEvent):void {

    }

    private function onLinkQA(event:MouseEvent):void {

    }

    private function onLinkReport(event:MouseEvent):void {

    }

    private function onLinkReward(event:MouseEvent):void {

    }

    private function onLinkDownLoad(event:MouseEvent):void {

    }

    public function LeftViewMediator() {
      super();
    }
  }
}
