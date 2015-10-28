/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.modules.init {
  import bobo.config.FileConfig;
  import bobo.config.InitConfig;
  import bobo.constants.ActionMessageUtil;
  import bobo.framework.event.SimpleEvent;
  import bobo.modules.launch.Launcher;
  import bobo.modules.launch.ModulesManager;
  import bobo.modules.main.RoomModel;
  import bobo.modules.net.MessageSender;
  import bobo.modules.user.UserInfoModel;
  import bobo.modules.video.VideoModel;
  import bobo.util.app.framework.MessageCenter;
  import bobo.util.app.framework.NetWork;
  import bobo.util.net.NetWorkCore;

  import com.plugin.log.LogUtil;

  import robotlegs.bender.bundles.mvcs.Command;

  public class InitMainShellCmd extends Command {
    [Inject]
    public var simple:SimpleEvent;
    [Inject]
    public var sender:MessageSender;
    [Inject]
    public var netWork:NetWork;
    [Inject]
    public var mainModel:RoomModel;

    [Inject]
    public var launcher:Launcher;
    [Inject]
    public var messageCenter:MessageCenter;
    [Inject]
    public var launcherManager:ModulesManager;

    override public function execute():void {
      super.execute();
      initRoomFromConfig();
      LogUtil.info("init main shell ","InitMainShellCmd");
      launcherManager.init();
      netWork.init({},new NetWorkCore());
      messageCenter.init("main");
      netWork.connectionReadySignal.addOnce(onReady);
      netWork.login(InitConfig.url,InitConfig.userId,InitConfig.roomId);

      launcher.init(FileConfig.commonFiles);
      launcher.launchMultiple(FileConfig.modulesFiles);

    }

    private function initRoomFromConfig():void{
      mainModel.roomId = InitConfig.roomId;
      mainModel.self = new UserInfoModel(null);
      mainModel.self.userId = InitConfig.userId;
    }

    private function onReady():void {
      sender.enterRoom();
    }

    public function InitMainShellCmd() {
      super();
    }
  }
}
