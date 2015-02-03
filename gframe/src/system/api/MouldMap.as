/**
 * Created by wbguan on 2015/2/2.
 */
package system.api {
  import system.mould.Mould;

  public class MouldMap {
    private var _mould:Object = {}
    protected static var _instance:MouldMap;
    public static function get instance():MouldMap{
      if(_instance == null){
        _instance = new MouldMap();
      }
      return _instance;
    }
    public function add(action:String,clazz:Class):void{
      _mould[action] = clazz;
    }
    public function getClass(action:String):Class{
      return _mould[action]
    }
    public function MouldMap() {
    }
  }
}
