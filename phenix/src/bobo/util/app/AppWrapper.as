/**
 * Created by wbguan on 2015/5/5.
 */
package bobo.util.app {
  import bobo.util.net.NetWorkCore;
  import com.util.net.sdk.ConnectionEvent;
  import com.util.net.sdk.IConnection;

  import flash.display.DisplayObject;

  import flash.display.DisplayObjectContainer;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.HTTPStatusEvent;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.net.URLStream;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.ByteArray;
  import flash.utils.getDefinitionByName;

  public class AppWrapper extends Sprite {
    private var _core:IConnection;
    private var _root:DisplayObjectContainer;
    private var _appUrl:String = "";
    private var _game:IApp;
    private var _userId:String = "";
    private var _captchaCode:String = "";
    private var _token:String = "";
    private var _timestamp:String = "";
    private var _random:String = "";
    private var _domain:ApplicationDomain;
    private var _fp:String = ""
    private var loader:Loader;
    private var stream:URLStream = new URLStream();
    private var _loaded:Boolean = false;
    private var bytes:ByteArray = new ByteArray();

    private var _roomId:int = 0;
    private var _flag:Boolean = false;

    public function AppWrapper(domain:ApplicationDomain) {
      super();
      _domain = domain;
    }
    private function initListener():void{
      _core.addEventListener(ConnectionEvent.CONNECTED,onConnected);
      _core.addEventListener(ConnectionEvent.RECEIVED,onReceive);
    }

    private function initInstance():void{
      _core = new NetWorkCore();
    }

    private function load():void{
      var req:URLRequest = new URLRequest();
      req.url = this._appUrl;
      loader = new Loader();
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      if(!_loaded) {
        stream.load(req);
        stream.addEventListener(HTTPStatusEvent.HTTP_STATUS, streamStatus);
        stream.addEventListener(Event.COMPLETE, streamComplete);
      }else{
        loader.loadBytes(bytes,new LoaderContext(false,_domain));
      }
    }

    private function streamComplete(event:Event):void {
      stream.readBytes(bytes);
      loader.loadBytes(bytes,new LoaderContext(false,_domain));
      stream.close();
      _loaded = true;
      this.dispatchEvent(new AppEvent(AppEvent.SWF_LOADED));
    }

    private function streamStatus(event:HTTPStatusEvent):void {

    }
    /*
     * @args [url,userId,captchaCode,token,timestamp,random,fp]
     */
    public function init(root:DisplayObjectContainer,appUrl:String,...args):void{
      _root = root;
      initInstance();
      initListener();
      var url:String = args[0];
      _userId = args[1];
      _captchaCode = args[2];
      _token = args[3];
      _timestamp = args[4];
      _random = args[5];
      _fp = args[6];
      _appUrl = appUrl;
      _core.login(url,"",0);
    }

    public function initExistCore(root:DisplayObjectContainer,param:IConnection,appUrl:String,roomId:int,userId:String,flag:Boolean = false):void{
      _root = root
      _core = param;
      _appUrl = appUrl;
      _roomId = roomId;
      _userId = userId;
      _flag = flag
      if(!_core.ready){
        throw new Error("Net Work Core is not ready");
      }else{
        loadAndLocal();
      }
    }
    private function loadAndLocal():void{
      if(CONFIG::LOCALE){
        var clazz:Class = getDefinitionByName("bobo.game.MainGame") as Class
        this._game = new clazz;
        newInstance();
      }else{
        load();
      }
    }
    private function newInstance():void{
      this._root.addChild(_game as DisplayObject);
      _game.init(this._core,_roomId,_userId,_flag);
      _flag = false;
      this.dispatchEvent(new AppEvent(AppEvent.NEW_INSTANCE));
    }
    private function onSecurityError(event:SecurityErrorEvent):void {
      trace("app wrapper "+ event.text);
    }

    private function onIOError(event:IOErrorEvent):void {
      trace("app wrapper "+ event.text);
    }

    private function onComplete(event:Event):void {
      var target:LoaderInfo = event.currentTarget as LoaderInfo;
      _game = target.content as IApp;
      newInstance();
    }

    private function onConnected(event:ConnectionEvent):void {
      _core.removeEventListener(ConnectionEvent.CONNECTED,onConnected);
      _core.send(JSON.stringify({"action": "init",
        "userId": _userId,
        "captchaCode": _captchaCode,
        "captchaToken":"",
        "fp":_fp,
        "platform": "pc",
        "token": _token,
        "timestamp": _timestamp,
        "random": _random,
        "roomId":100397//modified the param when we debug with server
      }))
      loadAndLocal();
      this.dispatchEvent(new AppEvent(AppEvent.ATTESTED));
    }

    private function onReceive(event:ConnectionEvent):void {
      _core.removeEventListener(ConnectionEvent.RECEIVED,onReceive);
    }
    public function abort():void{
      if(_game != null){
        _game.dispose();
      }
      if(this.loader!=null) {
        loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
        loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
        loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        this.loader.unloadAndStop();
        this.loader = null;
      }
    }
    public function dispose():void {
      abort();
      _loaded = false;
      if(stream!=null) {
        stream.removeEventListener(HTTPStatusEvent.HTTP_STATUS, streamStatus);
        stream.removeEventListener(Event.COMPLETE, streamComplete);
      }
      bytes.clear();
    }

    public function get game():IApp {
      return _game;
    }
  }
}
