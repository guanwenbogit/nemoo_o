/**
 * Created by wbguan on 2015/3/9.
 */
package util.ui.bitmapSheet {
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;

  public class SheetLoader {
    private var _loader:Loader;
    private var _urlLoader:URLLoader;
    private var _loaded:int = 0;
    private var _callBack:Function;
    public function SheetLoader() {
      _loader = new Loader();
      _urlLoader = new URLLoader();
    }

    public function load(sheetUrl:String,jsonUrl:String,callBack:Function):void{
      addListener();
      var sheetReq:URLRequest = new URLRequest(sheetUrl);
      var jsonReq:URLRequest = new URLRequest(jsonUrl);
      _callBack = callBack;

      _loader.load(sheetReq);
      _urlLoader.load(jsonReq);
    }
    private function call(param1:DisplayObject,param2:Object):void{
      if(_loaded == 2){
        if(_callBack != null){
          _callBack(param1,param2);
        }
      }
    }
    private function onComplete(event:Event):void {
      _loaded++;
      call(_loader.content,_urlLoader.data);
    }
    private function addListener():void{
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
      _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      _urlLoader.addEventListener(Event.COMPLETE, onComplete);
      _urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
      _urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
    }

    private function onSecurityError(event:SecurityErrorEvent):void {
      _loaded++;
      call(null,null);
    }

    private function onError(event:IOErrorEvent):void {
      _loaded++;
      call(null,null);
    }
    private function removeListener():void{
      if(_loader != null) {
        _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
        _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
        _loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      }
      if(_urlLoader!=null) {
        _urlLoader.removeEventListener(Event.COMPLETE, onComplete);
        _urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, onError);
        _urlLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      }
    }
    public function dispose():void {
      removeListener();
      _callBack = null;
      if(this._loader != null){
        this._loader.unload();
      }
      this._loader = null;
      this._urlLoader = null;
    }
  }
}
