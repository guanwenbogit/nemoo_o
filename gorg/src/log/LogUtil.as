/**
 * Created by wbguan on 2015/7/15.
 */
package log {
  import avmplus.getQualifiedClassName;

  import flash.text.TextField;

  public class LogUtil extends Object {
    protected static var _txts:Vector.<TextField> = new <TextField>[];

    public function LogUtil() {
      super();
    }
    public static function getStrByInfo(info:LogInfo):String{
      var result:String = "";
      result = "["+info.type+"]";
      if(info.source!=null){
        var clazz:String = getQualifiedClassName(info.source);
        result = result+clazz+"\n";
      }
      result = result + info.message;
      return result;
    }
    public static function getTxt():TextField{
      var result:TextField ;
      result = _txts.pop();
      if(result == null){
        result = new TextField();
      }
      return result;
    }
    public static function collection(txt:TextField):void{
      txt.text = "";
      _txts.push(txt);
    }
  }
}
