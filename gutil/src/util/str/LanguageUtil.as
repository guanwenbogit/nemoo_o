/**
 * Created by wbguan on 2015/5/25.
 */
package util.str {
  public class LanguageUtil extends Object {
    private static var _map:Object = {};
    public function LanguageUtil() {
      super();
    }
    public static function init(obj:Object):void{

    }

    public static function getContent(key:String):String{
      var result:String = "";
      result = _map[key];
      return result;
    }
  }
}
