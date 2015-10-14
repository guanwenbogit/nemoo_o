/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.modules.plugin {

  import flash.utils.Dictionary;
  public class PluginsCollection extends Object {
    private var _map:Dictionary = new Dictionary();

    public function append(name:String,plugin:PluginPreLoader):void{
      var tmp:PluginPreLoader;
      tmp = _map[name] as PluginPreLoader;
      if( tmp == null){
        tmp = plugin;
        _map[name] = tmp;
      }else{
        throw Error("there has been a plugin named " + name + " in the collection");
      }
    }
    public function getPluginPreLoader(url:String,name:String):PluginPreLoader{
      var result:PluginPreLoader;
      result = _map[name];
      if(result == null){
        result = new PluginPreLoader(url,null,50,50);
      }
      return result;
    }

    public function hasLoaded(name:String):Boolean{
      var result:Boolean = false;
      result = (_map[name] != null)
      return result;
    }

    public function remove(name:String):PluginPreLoader{
      var result:PluginPreLoader;
      result = _map[name] as PluginPreLoader;
      if(result != null){
        _map[name] = null;
        delete _map[name];
      }
      return result;
    }
    public function PluginsCollection() {
      super();
    }
  }
}
