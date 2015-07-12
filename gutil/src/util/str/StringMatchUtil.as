/**
 * Created by wbguan on 2015/5/25.
 */
package util.str {
  import mx.utils.StringUtil;

  public class StringMatchUtil extends Object {

    public function StringMatchUtil() {
      super();
    }
    public static function getContent(key:String,...args):String{
      var result:String = "";
      result = LanguageUtil.getContent(key);
      if(result==null){
        result = key;
      }
      result = StringUtil.substitute(result,args);
      return result;
    }
  }
}
