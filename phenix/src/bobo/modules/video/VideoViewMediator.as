/**
 * Created by wbguan on 2015/8/26.
 */
package bobo.modules.video {

  import bobo.util.AlignUtil;

  import flash.geom.Point;

  import robotlegs.bender.bundles.mvcs.Mediator;

  public class VideoViewMediator extends Mediator {
    [Inject]
    public var view:VideoView;
    [Inject]
    public var videoModel:VideoModel;

    override public function initialize():void {
      super.initialize();
      view.init(videoModel.userNum,480,360);
      view.play(videoModel.url,videoModel.userNum);
      videoModel.userNumSignal.add(onUserNumChange);
      videoModel.urlSignal.add(onUrlChange);
      AlignUtil.align(view,AlignUtil.H_CENTER, AlignUtil.V_TOP,new Point(0,30));
    }

    private function onUrlChange():void {

    }

    private function onUserNumChange():void {

    }

    public function VideoViewMediator() {
      super();
    }
  }
}
