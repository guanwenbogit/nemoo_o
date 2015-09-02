/**
 * Created by wbguan on 2015/6/10.
 */
package bobo.util {
  public class LevelMap {
    private var _map:Object = [];
    private var _source:Array = [];
    public function LevelMap() {
    }

    public function init(source:Object):void {
      _source = source as Array;
      for each(var obj:Object in _source){
        _map[obj["grade"]] = obj;
      }
    }
    public function getLvlName(grade:int):String{
      var result:String = "";
      var obj:Object = _map[grade];
      if(obj ==null) {
        obj = _map[1];
      }
      result = obj["name"];
      return result;
    }
    public function getLvlExp(grade:int):int{
      var result:int = 0;
      var obj:Object = _map[grade];
      if(obj ==null) {
        obj = _map[1];
      }
      result = obj["score"];
      return result;
    }
    public function get source():Array {
      return _source;
    }
  }
}
