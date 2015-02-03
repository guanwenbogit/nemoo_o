/**
 * Created by wbguan on 2015/1/23.
 */
package system.api.hub {
  import mx.core.SpriteAsset;

  public class HubPool {
//    protected static var _instance:HubPool;
    private var _map:Object = {};
//    public static function get instance():HubPool{
//      if(_instance == null){
//        _instance = new HubPool();
//      }
//      return _instance;
//    }
    public function getHubByName(name:String):Hub{
      var result:Hub;
      result = _map[name] as Hub;
      if(result == null){
        result = new Hub();
        this._map[name] = result;
      }
      return result;
    }
    public function removeHub(name:String):Hub{
      var result:Hub;
      result = _map[name] as Hub;
      if(result != null){
        result.dispose();
        this._map[name] = null;
        delete  this._map[name];
      }
      return result;
    }
    public function HubPool() {
    }
  }
}
