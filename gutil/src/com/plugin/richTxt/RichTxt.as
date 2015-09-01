/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {
  import com.plugin.richTxt.IRichElement;
  import com.plugin.richTxt.IRichTextField;
  import com.util.ui.shape.LRRectangle;

  import flash.display.DisplayObject;

  import flash.display.Sprite;
  import flash.text.TextFormat;

  public class RichTxt extends Sprite {
    private var _core:IRichTextField;
    private var _imgMapping:IRichImgMapping;
    private var _bg:DisplayObject;
    private var _tf:TextFormat;
    public function RichTxt() {
      super();

    }
    public function setFormat(tf:TextFormat):void{
      _tf = tf;
      this._core.setFormat(_tf);
    }
    public function setBg(flag:Boolean,color:uint,alpha:Number = 1.0):void{
      this._core.setBg(flag,color,alpha)
    }
    public function inputAble(flag:Boolean):void{
      _core.setInput(flag);
    }
    public function init(mapping:IRichImgMapping,core:IRichTextField):void{
      _imgMapping = mapping;
      _core = core;
      _core.onLink = onLink;
      this.addChild(_core as DisplayObject);
      _bg = new LRRectangle(1,1,0xffffff,0);
      this.addChildAt(_bg,0);
    }
    public function setMapping(mapping:IRichImgMapping):void{
      _imgMapping = mapping;
    }
    private function onLink(id:String):void {
      trace("link click " +id )
    }
    public function appendTxt(value:String):void{
       this._core.append(strToObj(value));
    }
    public function appendGraphics(id:String,obj:DisplayObject):void{
      this._core.append(new <IRichElement>[this._core.getGraphics(obj,id)]);
    }
    public function append(param:Vector.<IRichElement>){
      this._core.append(param);
    }
    public function appendParagraph(param:Vector.<IRichElement>){
       this._core.appendParagraph(param);
    }
    private function strToObj(str:String):Vector.<IRichElement>{
      var result:Vector.<IRichElement>= new <IRichElement>[];
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
          if(content.length > 0) {
            var g:IRichElement = parseEle(content);
            var last:int = buffer.lastIndexOf("[");
            var restr:String = buffer.slice(0, last);
            var span:IRichElement = _core.getSpan(restr,restr);
            result.push(span,g);
            buffer = "";
          }
          left = i;
        }
      }
      if(buffer.length > 0){
        var s:IRichElement  = _core.getSpan(buffer,buffer);
        result.push(s);
      }
      return result;
    }

    protected function parseEle(content:String):IRichElement {
      var result:IRichElement;

      if(content.indexOf("l:")>=0){
        var obj:Object = {};
        var arr:Array = content.split(",");
        for each(var str:String in arr){
          var tmp:Array = str.split(":");
          obj[tmp[0]] = tmp[1];
        }

        if(obj != null) {
          result = _core.getLink(obj["l"],obj["id"])
        }else{
          result = _core.getSpan(content,content);
        }
      }else if(content.indexOf("g:")>=0) {
        if(_imgMapping !=null) {
          var id:Array =content.split(":");
          result = _core.getGraphics(_imgMapping.getDisplayObj(id[1]),id[1])
        }
      }else{
        result = _core.getSpan(content,content);
      }
      return result;
    }
    public function get text():String{
      return _core.richText;
    }
    public function set text(value:String):void{
      _core.richText = value;
    }
    public function selectable(flag:Boolean):void{
      this._core.setSelectable(flag);
    }
    public function render():void {
      _core.render();
    }

    public function setFocus():void {
      _core.setFocus();
    }

    public function setMultiline(b:Boolean):void {
      _core.setMultiline(b);
    }
    public function resize(w:int ,h:int):void{
      trace("rich txt h" + _core.height);
      trace("rich txt w" + _core.width);
      _core.resize(w,h);
      _bg.width = w;
      _bg.height = h;
      trace("rich txt h" + _core.height);
      trace("rich txt w" + _core.width);
    }

    public function get maxPixelV():int {
      return this._core.pixelMaxScrollV;
    }
    public function get pixelScrollV():int{
      return _core.pixelScrollV;
    }
    public function set pixelScrollV(value:int):void{
      _core.pixelScrollV = value;
    }
    public function setWrap(flag:Boolean):void{
      this._core.wordWrap = flag;
    }

    override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      this._core.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      this._core.removeEventListener(type, listener, useCapture);
    }

    override public function hasEventListener(type:String):Boolean {
      return this._core.hasEventListener(type);
    }
  }
}
