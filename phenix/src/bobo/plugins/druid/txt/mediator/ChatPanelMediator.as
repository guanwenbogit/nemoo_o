/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.plugins.druid.txt.mediator {
  import bobo.plugins.druid.txt.ChatConstants;
  import bobo.plugins.druid.txt.ChatPanel;

  import flash.display.Loader;

  import robotlegs.bender.bundles.mvcs.Mediator;

  import tools.uiProvider.NProvider;

  public class ChatPanelMediator extends Mediator {
    [Inject]
    public var view:ChatPanel;

    override public function initialize():void {
      super.initialize();
      NProvider.loadSwf(ChatConstants.CHAT_SWF,onLoaded);
    }

    private function onLoaded(loader:Loader):void {
      view.init(null);
    }

    public function ChatPanelMediator() {
      super();
    }
  }
}
