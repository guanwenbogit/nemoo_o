/**
 * Created by wbguan on 2015/9/1.
 */
package imgUI {
  import com.util.ui.unity.LR9Bitmap;

  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.net.URLRequest;

  public class LR9BitmapDemo extends Sprite {
    private var _loader:Loader;
    public function LR9BitmapDemo() {
      super();
      _loader = new Loader();
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _loader.load(new URLRequest("back_btn.png"));
    }

    private function onComplete(event:Event):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      var bit:LR9Bitmap = new LR9Bitmap(target.content,5,5,5,5);
      this.addChild(bit);
      bit.resizeCenter(10,10);
    }
  }
}
