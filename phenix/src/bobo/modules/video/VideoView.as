/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.modules.video {
  import bobo.modules.video.player.LiveVideoPlayer;

  import com.plugin.log.LogUtil;

  import flash.display.Sprite;

  public class VideoView extends Sprite {
    private var _core:LiveVideoPlayer;
    public function VideoView() {
      super();
    }
    public function init(userNum:int,w:int,h:int):void{
      _core = new LiveVideoPlayer(userNum,w,h);
      this.addChild(_core.video);
    }

    public function play(url:String,userNum:int):void{
      LogUtil.info(url,"VideoView",true);
      _core.play(userNum,url);
    }
    public function close():void{
      _core.close();
    }
    public function clear():void{
      _core.clear();
    }
  }
}
