/**
 * Created by wbguan on 15/11/25.
 */
package com.netease.ugc.live.ui.unity {

  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.TextFormat;
  import flash.utils.Dictionary;
  
  public class FormatTxt extends Object {
    private var _txt:TextField = new TextField();
    public function FormatTxt() {
      super();
      _txt.multiline = true;
      _txt.autoSize = TextFieldAutoSize.LEFT;
      _txt.mouseEnabled = false;
    }

    public function setTxt(...args):void{
      var dic:Object = new Object();
      var index:Array = [];
      var value:String = "";
      var start:int = 0;
      var lastLen:int = 0;
      for each(var obj:Object in args){
        if(obj is String){
          start = value.length;
          lastLen = String(obj).length;
          value+=String(obj);
        }else if(obj is TextFormat){
          index.push(start);
          dic[start] = {tf:obj,len:lastLen};
        }
      }
      _txt.text = value;
      for each(var key:int in index){
        var obj:Object = dic[key];
        var tf:TextFormat = obj["tf"];
        var len:int = obj["len"];
        if(int(key)<value.length) {
          _txt.setTextFormat(tf as TextFormat, int(key),key+len);
        }
      }
    }
    public function set text(value:String):void{
      _txt.text = value;
    }
    public function get text():String{
      var result:String = _txt.text;
      return result;
    }
    public function setDefFormat(tf:TextFormat):void{
      _txt.defaultTextFormat=tf;
      _txt.setTextFormat(_txt.defaultTextFormat);
    }

    public function get txt():TextField{
      return _txt;
    }

  }
}
