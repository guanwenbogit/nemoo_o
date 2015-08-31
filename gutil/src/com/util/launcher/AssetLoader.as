package com.util.launcher {
  import flash.display.LoaderInfo;
  import flash.system.LoaderContext;
  import flash.net.URLRequest;
  import flash.events.SecurityErrorEvent;
  import flash.events.IOErrorEvent;
  import flash.events.Event;
  import flash.display.Loader;
  import flash.system.ApplicationDomain;
  import flash.events.EventDispatcher;

  /**
   * @author wbguan
   */
  public class AssetLoader extends EventDispatcher {
    private var _loader:Loader;
    private var _asset:Asset;
	private var _context:LoaderContext;
    public function AssetLoader(url:String,name:String,isRetry:Boolean = false,domain:ApplicationDomain = null) {
      super(null);
      _asset = new Asset();
      _asset.name = name;
      _asset.url = url;
      _asset.isRetry = isRetry;
	  _context = new LoaderContext(false,domain);
      _loader = new Loader();
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
	  _loader.contentLoaderInfo.addEventListener(Event.INIT, onInit);
	  _loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
    }
    private function onSecurityError(event:SecurityErrorEvent):void{
		this.dispatchEvent(new AssetEvent(AssetEvent.SECURITY_ERROR_EVENT, this._asset));
	}
    private function onInit(event:Event):void{
		trace("[AssetLoader] onint url: " +(event.target as LoaderInfo).url);
		this.dispatchEvent(new AssetEvent(AssetEvent.INIT_EVENT, this._asset));
	}
	private function onIOError(event : IOErrorEvent) : void {
		trace("[AssetLoader] onIOError url: " +(event.target as LoaderInfo).loaderURL);
		this.dispatchEvent(new AssetEvent(AssetEvent.ERROR_EVENT, this._asset));
    }
    public function load():void {
	    var req:URLRequest = new URLRequest();
		req.url = this._asset.url;
		trace("[AssetLoader] load : " +this._asset.url);
        this._loader.load(req,_context);
    }
    
    private function onComplete(event:Event):void {
      this.dispatchEvent(new AssetEvent(AssetEvent.COMPLETE_EVENT, this._asset));
    }
    
  }
}
