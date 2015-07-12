package util {
  import flash.text.TextField;
  /**
   * @author wbguan
   */
  public class StringCutUtil extends Object {
    private static const doubleCharReg:RegExp = /[^x00-xff]/g;
    public static function filter_R(str:String):String{
      return str.replace(/[\n|\r]/g,"");
    }
    public static function cut(content:String,remain:int):String{
      var result:String = content;
      if(result.length > remain){
        result = result.substr(0,remain);
        result += "...";
      }
      return result ;
    }
    public static function cutTxt(txt:TextField,maxWidth:int):Boolean{
      var result:Boolean = false;
      if(txt.textWidth > maxWidth){
        var perW:Number = txt.textWidth/txt.length;
        var text:String = txt.text;
        txt.text = "...";
        var span:Number = txt.textWidth;
        var len:int = Math.floor((maxWidth-span) / perW);
        if(len>0){
          text = text.substr(0,len)  ;
        }
        txt.text = text + "...";
        result = true;
      }
      return result;
    }
    
    public static function formatString(source:String, max:uint,replace:String = "..."):String {
      if (!source || source.length == 0) {
        return "";
      }
      
      var len:int = 0;
      for (var i:int = 0; i < source.length; i++) {
        var code:uint = source.charCodeAt(i);
        if (code > 0x7F) {
          len += 2;
        } else {
          len++;
        }
        
        if (len > max) {
          return source.substr(0, i) + replace;
        }
      }
      
      return source;
    }

    public static function calcStr(str:String):int {
       var len:int = 0;
      for (var i:int = 0; i < str.length; i++) {
        var code:uint = str.charCodeAt(i);
        if (code > 0x7F) {
          len += 2;
        } else {
          len++;
        }
      }
      return len;
    }
    
    public static function calcStringLength(source:String):int {
      if (!source) {
        return 0;
      }
      
      var char:Array = source.match(doubleCharReg);
      const doubleLen:int = char.length;
      var leftLength:int = source.length - doubleLen;
      return leftLength + doubleLen * 2;
    }
  }
}
