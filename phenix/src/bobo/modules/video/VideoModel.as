/**
 * Created by wbguan on 2015/8/26.
 */
package bobo.modules.video {
  import org.osflash.signals.Signal;

  public class VideoModel {
    private var _url:String = "http://extapi.live.netease.com/redirect/video/{0}";
    private var _userNum:int = -1;
    public var userNumSignal:Signal = new Signal();
    public var urlSignal:Signal = new Signal();
    public function VideoModel() {
    }

    public function get url():String {
      return _url;
    }

    public function set url(value:String):void {
      _url = value;
      urlSignal.dispatch();
    }

    public function get userNum():int {
      return _userNum = 12639317;
    }

    public function set userNum(value:int):void {
      _userNum = value;
      userNumSignal.dispatch()
    }
  }
}
