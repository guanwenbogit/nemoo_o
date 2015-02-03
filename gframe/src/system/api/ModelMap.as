/**
 * Created by wbguan on 2015/2/2.
 */
package system.api {
  public class ModelMap {

    private var _models:Object = {};
    protected static var _instance:ModelMap;
    public static function get instance():ModelMap {
      if (_instance == null) {
        _instance = new ModelMap();
      }
      return _instance;
    }

    public function add(clazz:Class,name:String):void {
      var model:IModel = new clazz();
      _models[name] = model;
    }

    public function ModelMap() {
    }
    public function getModel(name:String):IModel {
      var result:IModel = this._models[name] as IModel;
      return result;
    }

  }
}
