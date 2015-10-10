/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.config {
  import bobo.constants.MessageType;
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.modules.plugin.PluginPreLoader;
  import bobo.modules.plugin.PluginPreLoaderMediator;
  import bobo.modules.plugin.PluginsCollection;
  import bobo.modules.hud.HudForm;
  import bobo.modules.init.DashBoardCmd;
  import bobo.modules.init.InitMainShellCmd;
  import bobo.modules.launch.Launcher;
  import bobo.modules.launch.ModulesManager;
  import bobo.modules.left.FeatureMediator;
  import bobo.modules.left.FeaturePanel;
  import bobo.modules.left.LeftInitCmd;
  import bobo.modules.left.LeftView;
  import bobo.modules.left.LeftViewMediator;
  import bobo.modules.main.MainView;
  import bobo.modules.main.MainViewMediator;
  import bobo.modules.main.RoomModel;
  import bobo.modules.net.MessageSender;
  import bobo.modules.scene.SceneForm;
  import bobo.modules.video.VideoModel;
  import bobo.modules.video.VideoView;
  import bobo.modules.video.VideoViewMediator;
  import bobo.util.app.framework.MessageCenter;
  import bobo.util.app.framework.NetWork;
  import bobo.util.net.event.MessageSimpleEvent;

  import com.util.layer.Layer;


  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
  import robotlegs.bender.framework.api.IConfig;
  import robotlegs.bender.framework.api.IInjector;

  import tools.uiProvider.NProvider;

  public class AppConfig implements IConfig {
    [Inject]
    public var injector:IInjector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var cmdMap:IEventCommandMap;
    [Inject]
    public var signalMap:ISignalCommandMap;
    [Inject]
    public var contextView:ContextView;
    public function AppConfig() {
    }

    public function configure():void {

      injector.map(RoomModel).asSingleton();
      injector.map(NetWork).asSingleton();
      injector.map(Launcher).asSingleton();
      injector.map(MessageCenter).asSingleton();
      injector.map(MessageSender).asSingleton();
      injector.map(VideoModel).asSingleton();
      injector.map(ModulesManager).asSingleton();
      injector.map(SceneForm).asSingleton();
      injector.map(HudForm).asSingleton();
      injector.map(Layer).asSingleton();
      injector.map(PluginsCollection).asSingleton();
      mediatorMap.map(MainView).toMediator(MainViewMediator);
      mediatorMap.map(VideoView).toMediator(VideoViewMediator);
      mediatorMap.map(LeftView).toMediator(LeftViewMediator);
      mediatorMap.map(FeaturePanel).toMediator(FeatureMediator);
      mediatorMap.map(PluginPreLoader).toMediator(PluginPreLoaderMediator);
      cmdMap.map(SimpleType.MAIN_SHELL_INIT,SimpleEvent).toCommand(InitMainShellCmd);
      cmdMap.map(MessageType.DASHBOARD,MessageSimpleEvent).toCommand(DashBoardCmd);

    }
  }
}
