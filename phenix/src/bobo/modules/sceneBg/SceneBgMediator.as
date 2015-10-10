/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.modules.sceneBg {
  import robotlegs.bender.bundles.mvcs.Mediator;

  public class SceneBgMediator extends Mediator {
    [Inject]
    public var view:SceneBgView;

    override public function initialize():void {
      super.initialize();
      view.load("http://file.ws.126.net/liveshow/other/bg2.jpg");
    }

    public function SceneBgMediator() {
      super();
    }
  }
}
