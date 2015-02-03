package image {
  import flash.events.ProgressEvent;
  import flash.net.URLStream;
  import flash.geom.Point;
  import flash.display.LoaderInfo;
  import flash.display.BitmapData;
  import flash.events.SecurityErrorEvent;
  import flash.events.IOErrorEvent;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.display.Loader;
  import flash.geom.Rectangle;
  import flash.display.Bitmap;
  import flash.display.Sprite;
  import flash.events.EventDispatcher;
  import flash.events.IEventDispatcher;

  /**
   * @author wbguan
   */
  public class ImageHelper extends EventDispatcher {
    protected static var _instance:ImageHelper;
    
    private var bitmaps:Object = {};
    private var callBacks:Object = {};
    public function ImageHelper(target:IEventDispatcher = null) {
      super(target);
    }
    public function getImageSprite(url:String,rect:Rectangle,callBack:Function = null,scale:int = 0):Sprite{
      var result:Sprite = new Sprite();
      var bitmap:Bitmap = this.getImageBitMap(url, rect.width, rect.height,callBack,true,scale);
      result.addChild(bitmap);
      bitmap.x = rect.x;
      bitmap.y = rect.y;
      return result;
    }
    private function onComplete(event:Event):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      target.removeEventListener(Event.COMPLETE, onComplete);
      target.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
      target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      var bitmap:Bitmap = target.content as Bitmap;
      var key:String = target.loader.name;
      var buffer:Bitmap = bitmaps[key] as Bitmap;
      var func:Function = callBacks[key] as Function;
      if(buffer != null){
        buffer.bitmapData.copyPixels(bitmap.bitmapData,
         new Rectangle(0,0,bitmap.width,bitmap.height), 
         new Point(Math.floor((buffer.width - bitmap.width)/2),Math.floor((buffer.height - bitmap.height)/2)));
        buffer.smoothing = true;
      }
      if(func != null){
        func(buffer,new Rectangle(0,0,bitmap.width,bitmap.height));
        callBacks[key] = null;
        delete callBacks[key];
      }
      target.loader.unload();
      bitmaps[key] = null;
      delete bitmaps[key];
    }
    private function onIOError(event:IOErrorEvent):void {
    }

    private function onSecurityError(event:SecurityErrorEvent):void {
    }
    public function getImageBitMap(urlparam:String,width:int,height:int,callBack:Function = null,cache:Boolean = true,scale:int = 0,smoothing:Boolean = false):Bitmap{
      var result:Bitmap = new Bitmap();
      var url:String = ImageBuffer.getResizeImageURL(urlparam, width, height,scale);
      var defData:BitmapData = ImageBuffer.instance.getImageByUrl(url);
      if(defData == null){
        var loader:Loader = new Loader();
        var urlRequest:URLRequest = new URLRequest(url);
        defData = new BitmapData(width, height,true,0xffffff);
        result.bitmapData = defData;
        result.smoothing = smoothing;
        bitmaps[loader.name] = result;
        if(callBack!= null){
          callBacks[loader.name] = callBack;
        }
        if(cache){
          ImageBuffer.instance.addImageByUrl(url, result);
        }
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        loader.load(urlRequest);
      }else{
        result.bitmapData = defData;
        result.smoothing = true;
        if(callBack != null){
          callBack(result);
        }
      }
      return result;
    }

    public function dispose():void {
    }

    public static function get instance():ImageHelper {
      if(ImageHelper._instance == null){
        ImageHelper._instance = new ImageHelper();
      }
      return _instance;
    }
  }
}
