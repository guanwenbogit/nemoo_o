/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {
  public class RichTxtUtil extends Object {
    public function RichTxtUtil() {
      super();
    }

    public static function trim(source:String):String{
      var result:String = source;
      result = result.replace(/<br>/g,"<br />");
      return result;
    }

    public static function strToObj(str:String):Array{
      var result:Array = [];
      var len:int = str.length;
      var buffer:String = "";
      var left:int = -1;
      for(var i:int = 0; i < len ; i++){
        var char:String = str.charAt(i);
        buffer += char;
        if(char == "["){
          left = i;
        }
        if(char == "]"){
          var content:String = str.slice(left + 1,i);
          var arr:Array = content.split(":");
          arr = arr.filter(filterEmpty);
          if(arr.length > 1) {
            var g:Object = {content: arr[1], type: arr[0]};
            var last:int = buffer.lastIndexOf("[");
            var restr:String = buffer.slice(0, last);
            var span:Object = {type: "txt", content: restr};
            result.push(span, g);
            buffer = "";
          }
          left = i;
        }
      }
      if(buffer.length > 0){
        var s:Object = {type:"txt",content:buffer};
        result.push(s);
      }
      return result;
    }

    private static function filterEmpty(element:String, index:int, arr:Array):Boolean {
      return (element != null && element.length>0);
    }

  }
}
