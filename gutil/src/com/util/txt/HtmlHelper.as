package com.util.txt {
  /**
   * @author wbguan
   */
  public class HtmlHelper extends Object {
    
    
    
    public static function encode(str:String):String{
       var s:String = "";   
       if(str == null || str.length == 0) return"";   
       s = str.replace(/&/g,"&amp;");   
       s = s.replace(/</g,"&lt;");   
       s = s.replace(/>/g,"&gt;");   
       s = s.replace(/ /g,"&nbsp;");   
       s = s.replace(/\"/g,"&quot;");   
       s = s.replace(/\n/g, "<br>");   
       s = s.replace(/\'/g, "&apos;");   
       return s;  
    }
    public static function decode(str:String):String {
       var s:String = "";   
       if(str == null || str.length == 0) return  "";   
       s = str.replace(/&amp;/g,"&");   
       s = s.replace(/&lt;/g,"<");   
       s = s.replace(/&gt;/g,">");   
       s = s.replace(/&nbsp;/g," ");   
       s = s.replace(/&quot;/g,"\"");   
       s = s.replace(/<br>/g, "\n");   
       s = s.replace(/&apos;/g, "'");   
       s = s.replace(/\n/g, "换行符");
       return s;   
    }
    
    public static function decodeWithWrap(str:String):String {
      var s:String = "";   
     if(str == null || str.length == 0) return  "";   
     s = str.replace(/&amp;/g,"&");   
     s = s.replace(/&lt;/g,"<");   
     s = s.replace(/&gt;/g,">");   
     s = s.replace(/&nbsp;/g," ");   
     s = s.replace(/&quot;/g,"\"");   
     s = s.replace(/<br>/g, "\n");   
     s = s.replace(/&apos;/g, "'");   
     return s;
    }
  }
}
