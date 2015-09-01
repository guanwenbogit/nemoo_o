/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {
  import flash.display.DisplayObject;
  import flash.events.IEventDispatcher;
  import flash.text.TextFormat;

  public interface IRichTextField extends IEventDispatcher{
    /**
     * onLink(id:String)
     * */
    function set onLink(onLink:Function):void;

    function appendParagraph(param:Vector.<IRichElement>):void;

    function render():void;

    function set richText(text:String):void;

    function get richText():String;

    function append(param:Vector.<IRichElement>):void;

    function setInput(flag:Boolean):void;
    function setSelectable(flag:Boolean):void;
    function setFocus():void;
    function getSpan(content:String,id:String):IRichElement;
    function getLink(content:String,id:String):IRichElement;
    function getGraphics(content:DisplayObject,id:String):IRichElement;
    function resize(w:int,h:int):void;
    function setFormat(tf:TextFormat);
    function setBg(flag:Boolean,color:uint,alpha:Number):void;
    function setMultiline(flag:Boolean):void;
    function get height():Number;
    function get width():Number;
    function get scrollV():int;
    function set scrollV(value:int):void;
    function get maxScrollV():int;
    function get pixelScrollV():int;
    function set pixelScrollV(value:int):void;
    function get pixelMaxScrollV():int;
    function get wordWrap():Boolean;
    function set wordWrap(value:Boolean):void;

  }
}
