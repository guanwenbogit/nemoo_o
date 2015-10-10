/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.modules.video {
  import bobo.modules.video.player.LiveVideoPlayer;

  import com.plugin.log.LogUtil;
  import com.util.ui.shape.LRRectangle;

  import flash.display.DisplayObject;

  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;

  public class VideoView extends Sprite {
    private var _bg:DisplayObject;
    private var _core:LiveVideoPlayer;
    public function VideoView() {
      super();
    }
    public function init(userNum:int,w:int,h:int):void{
      _bg = new LRRectangle(w,h,0x000000,0.3);
      _core = new LiveVideoPlayer(userNum,w,h);
      this.addChild(_bg);
      this.addChild(_core.video);
      var text:TextField = new TextField();
      text.width = 20;
      text.height = 10;
      this.addChild(text);
      text.multiline = true;
      text.text = "sadfasgasldjflk;sajdfasdfasg111";
      text.wordWrap = true;
      text.autoSize = TextFieldAutoSize.LEFT;
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
