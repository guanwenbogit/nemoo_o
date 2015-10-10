/**
 * Created by wbguan on 2015/9/18.
 */
package bobo.modules.druid {
  import bobo.modules.druid.txt.ChatConstants;
  import bobo.modules.druid.Druid;
  import bobo.modules.launch.Launcher;

  import com.plugin.log.LogUtil;

  import flash.display.Loader;

  import flash.display.Sprite;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;

  public class ChatViewDemo extends Sprite {
    private var _chatView:Druid;
    public function ChatViewDemo() {
      super();
      _chatView = new Druid(294,433);
      this.addChild(_chatView);
      var loader:Loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSwf);
      loader.load(new URLRequest("chat.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
    }

    private function onSwf(event:Event):void {
      NProvider.loadOrg(ChatConstants.BG_UI,ChatConstants.BG_UI_JSON,onLoaded);
    }

    private function onLoaded(org:NOrg):void {
      LogUtil.info("ui loaded ","ChatViewDemo");
      _chatView.init();
    }
  }
}
