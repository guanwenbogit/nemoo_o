/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.modules.plugin {
  import bobo.plugins.IPlugins;

  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.utils.getQualifiedClassName;


  public class PluginPreLoader extends PreLoadingView {
    private var _url:String = "";
    private var _plugin:IPlugins;
    private var _pluginLoader:Loader = new Loader();
    private var _success:Boolean = false;
    private var _clazz:String = "";
    private var _loaded:Boolean = false;


    public function PluginPreLoader(url:String, loading:DisplayObject, w:int, h:int) {
      super(loading, w, h);
      _url = url;
      _pluginLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _pluginLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _pluginLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
    }

    override public function get parent():DisplayObjectContainer {
      var result:DisplayObjectContainer;
      result = super.parent;
      if(result == null){
        if(_plugin != null && _plugin is DisplayObject){
          result = (_plugin as DisplayObject).parent;
        }
      }
      return result;
    }

    override public function init():void {
      super.init();
    }


    private function onSecurityError(event:SecurityErrorEvent):void {
//      LogUtil.error("Invalid plugin :" + _url + " | "+event.text,"PluginPreLoader");
    }

    private function onIOError(event:IOErrorEvent):void {
//      LogUtil.error("Invalid plugin :" + _url + " | "+event.text,"PluginPreLoader");
    }

    private function onComplete(event:Event):void {
      trace("PluginPreLoader load complete " + _url);
      _plugin = _pluginLoader.contentLoaderInfo.content as IPlugins;
      _clazz = getQualifiedClassName(_plugin);
      if (_plugin == null) {
      } else {
        _success = true;
        this.init();
      }
      this.dispatchEvent(new Event(Event.COMPLETE));
    }
    public function showPlugin():void{
      if(_plugin != null && this.parent != null) {
        if(_plugin is DisplayObject){
          var obj:DisplayObject = _plugin as DisplayObject;
          this.parent.addChildAt(obj,this.parent.getChildIndex(this));
          this.parent.removeChild(this);
          obj.x = this.parent.x;
          obj.y = this.parent.y;
        }else{
          trace("[PluginPreLoader] _plugins is not a display object. url : "+this._url);
        }
      }
    }
    public function load():void {
      if (!_loaded) {
        _pluginLoader.load(new URLRequest(_url), new LoaderContext(true, ApplicationDomain.currentDomain));
        _loaded = true;
      }
    }

    public function dispose():void {
      _pluginLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
      _pluginLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _pluginLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      _pluginLoader.unloadAndStop(true);
      _success = false;
      _loaded = false;
    }

    public function get plugin():IPlugins {
      var result:IPlugins;
      if (_success) {
        result = _plugin
      }
      return result;
    }

    public function get success():Boolean {
      return _success;
    }

    public function get clazz():String {
      return _clazz;
    }
  }
}
