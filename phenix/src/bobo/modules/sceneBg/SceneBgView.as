/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.modules.sceneBg {
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.ProgressEvent;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;

  public class SceneBgView extends PreLoadingView {

    private var _bg:DisplayObject;

    private var _urlReq:URLRequest;
    private var _loader:Loader;
    private var _urlStream:URLStream;
    private var _buffer:ByteArray = new ByteArray();
    private var _count:int =0;
    public function SceneBgView(loading:DisplayObject, w:int, h:int) {

      super(loading, w, h);
//      this.alpha = 0.5;
    }

    override public function init():void {
      super.init();
      _bg = new LRRectangle(_w,_h,0xffffff,0);
      this.addChild(_bg);
    }

    public function load(url:String):void{
      _buffer = new ByteArray();
      initInstance(url);
    }
//    "http://file.ws.126.net/liveshow/other/bg2.jpg"
    private function initInstance(url:String):void {
      _urlReq = new URLRequest(url);
      _loader = new Loader();
      _urlStream = new URLStream();
      _urlStream.addEventListener(ProgressEvent.PROGRESS, onProgress);
      _urlStream.addEventListener(Event.COMPLETE, onComplete);
      this.addChild(_loader);
      _urlStream.load(_urlReq);
      trace("[ImageTweenLoader/initInstance]");
      _loader.mouseEnabled = false;
    }

    private function onComplete(event : Event) : void {
      trace("[ImageTweenLoader/onComplete]");
      _urlStream.close();
    }

    private function onProgress(event : ProgressEvent) : void {
      _count++;
      _urlStream.readBytes(_buffer,_buffer.length);
      _loader.loadBytes(_buffer,new LoaderContext(false));
      trace("[ImageTweenLoader/onProgress] " + _count + " len: " + _buffer.length);
    }

  }
}
