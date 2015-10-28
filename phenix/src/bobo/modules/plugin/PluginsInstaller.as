/**
 * Created by wbguan on 2015/10/23.
 */
package bobo.modules.plugin {
  import bobo.plugins.IPlugins;

  import flash.display.DisplayObjectContainer;
  import flash.events.Event;
  import flash.geom.Point;

  import robotlegs.bender.extensions.matching.PackageFilter;
  import robotlegs.bender.framework.api.IContext;

  public class PluginsInstaller extends Object {

    private var _plugins:PluginsCollection;
    public function PluginsInstaller() {
      super();
    }
    public function install(url:String,name:String,context:IContext,target:DisplayObjectContainer = null,location:Point = null,callback:Function = null,...args):PluginPreLoader {
      var perLoader:PluginPreLoader = plugins.getPluginPreLoader(url, name);
      if (!perLoader.success) {
        if (target != null) {
          target.addChild(perLoader);
        }else{
          perLoader.addEventListener(Event.ADDED, function added(event:Event):void{
            perLoader.showPlugin();
          });
        }
        if (location != null) {
          perLoader.x = location.x;
          perLoader.y = location.y;
        }
        perLoader.addEventListener(Event.COMPLETE, function fun(event:Event):void {
          args.unshift(context)
          perLoader.plugin.init.apply(null,args);
          perLoader.showPlugin();
          if (callback != null) {
            callback();
          }
        });
        perLoader.load();
      }else{
        if (callback != null) {
          callback();
        }
      }
      return perLoader;
    }
    public function getPlugin(name:String):IPlugins{
      return plugins.getPlugin(name);
    }
    public function uninstall(name:String):PluginPreLoader{
      return plugins.remove(name);
    }
    public function uninstallObj(obj:PluginPreLoader):void{
      plugins.removeLoader(obj);
    }
    public function get plugins():PluginsCollection {
      if(_plugins == null){
        _plugins = new PluginsCollection();
      }
      return _plugins;
    }

    public function hasLoaded(name:String):Boolean {
      return plugins.hasLoaded(name);
    }
  }
}
