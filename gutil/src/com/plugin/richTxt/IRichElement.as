/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {
  import flash.text.TextFormat;

  public interface IRichElement {
    /*
    * s:span,l:link,g:graphics
    * */
    function get type():String;
    /*
    * txt,displayobj...
    * */
    function get content():Object;

    function get id():String;

    function set id(id:String):void;

    function set content(content:Object):void;

    function set type(type:String):void;
    function set tf(value:TextFormat);
    function get tf():TextFormat;
  }
}
