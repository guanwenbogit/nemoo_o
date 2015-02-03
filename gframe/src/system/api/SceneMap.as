/**
 * Created by wbguan on 2015/1/29.
 */
package system.api {
  public class SceneMap extends Object {
    private var _map:Object = {};
    protected static var _instance:SceneMap;
    public static function get Instance():SceneMap{
      if(_instance == null){
        _instance = new SceneMap();
      }
      return _instance;
    }
    public function addScene(scene:Class,key:Object):void{
      this._map[key] = scene;
    }
    public function getScene(key:Object):Class{
      if(this._map[key] == null){
        throw new Error("there is no key like :" + key.toString());
      }
      return this._map[key];
    }
    public function SceneMap() {
      super();
    }
  }
}
