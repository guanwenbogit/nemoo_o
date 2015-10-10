/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.modules.video {
  import bobo.config.InitConfig;
  import bobo.modules.main.RoomModel;
  import bobo.modules.scene.SceneForm;

  import com.plugin.log.LogUtil;

  import robotlegs.bender.bundles.mvcs.Command;

  public class VideoInitCmd extends Command {
    [Inject]
    public var room:RoomModel;
    [Inject]
    public var scene:SceneForm;
    [Inject]
    public var videoModel:VideoModel;

    override public function execute():void {
      super.execute();
      LogUtil.info("video","VideoInitCmd");
      videoModel.userNum = InitConfig.userNum;
      var video:VideoView = new VideoView();
      scene.video.addChild(video);
    }

    public function VideoInitCmd() {
      super();
    }

  }
}
