/**
 * Created by wbguan on 2015/3/3.
 */
package com.util {
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  public class SimpleLoader extends Object {
    private var _loader:Loader = new Loader();
    private var _func:Function;
    public function SimpleLoader() {
      super();
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
    }
    public function load(url:String,callBack:Function):void{
      var req:URLRequest = new URLRequest(url);
      _loader.load(req,new LoaderContext(false,ApplicationDomain.currentDomain));
      this._func = callBack;
      trace("load ============ :" + url);
    }
    public function loadWithoutDomain(url:String,callBack:Function,domain:ApplicationDomain = null):void{
      var req:URLRequest = new URLRequest(url);
      _loader.load(req,new LoaderContext(false,domain));
      this._func = callBack;
      trace("load ============ :" + url);
    }
    private function onSecurityError(event:SecurityErrorEvent):void {
      trace(event.text);
    }

    private function onIOError(event:IOErrorEvent):void {
      trace(event.text);
    }

    private function onComplete(event:Event):void {
      trace("compelte : " + event.target.url);
      _func(_loader);
    }
    public function get content():Object{
      return _loader.content;
    }
    public function dispose():void{
      _loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
      _loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurityError);
      this._loader.unloadAndStop(true);
      this._loader = null;
      this._func = null;
    }
  }
}
