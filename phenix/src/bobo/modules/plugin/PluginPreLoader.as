/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.modules.plugin {
  import bobo.plugins.IPlugins;

  import com.plugin.log.LogUtil;

  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;


  public class PluginPreLoader extends PreLoadingView {
    private var _url:String = "";
    private var _plugin:IPlugins;
    private var _pluginLoader:Loader = new Loader();
    private var _success:Boolean = false;
    public function PluginPreLoader(url:String,loading:DisplayObject, w:int, h:int) {
      super(loading, w, h);
      _url  = url;
      _pluginLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
      _pluginLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _pluginLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);

    }

    private function onSecurityError(event:SecurityErrorEvent):void {
      LogUtil.error("Invalid plugin :" + _url + " | "+event.text,"PluginPreLoader");
    }

    private function onIOError(event:IOErrorEvent):void {
      LogUtil.error("Invalid plugin :" + _url + " | "+event.text,"PluginPreLoader");
    }

    private function onComplete(event:Event):void {
      _plugin = _pluginLoader.contentLoaderInfo.content as IPlugins;
      if(_plugin == null){
        LogUtil.error("Invalid plugin :" + _url ,"PluginPreLoader");
      }else{
        _success = true;
      }
      this.dispatchEvent(new Event(Event.COMPLETE));
//      else{
//        this.init();
//        this.addChild(_plugin as DisplayObject);
//      }
    }

    public function load():void{
      _pluginLoader.load(new URLRequest(_url),new LoaderContext(true,ApplicationDomain.currentDomain));
    }

    public function dispose():void{
      _pluginLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
      _pluginLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
      _pluginLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
      _pluginLoader.unloadAndStop(true);
      _success = false;
    }

    public function get plugin():IPlugins {
      var result:IPlugins;
      if(_success) {
        result = _pluginLoader.contentLoaderInfo.content as IPlugins;
      }
      return result;
    }

    public function get success():Boolean {
      return _success;
    }
  }
}
