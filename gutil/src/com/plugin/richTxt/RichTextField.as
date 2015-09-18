/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {

  import fl.text.TLFTextField;


  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;
  import flash.text.engine.TextBaseline;


  import flashx.textLayout.edit.EditManager;
  import flashx.textLayout.edit.SelectionManager;
  import flashx.textLayout.elements.FlowElement;
  import flashx.textLayout.elements.InlineGraphicElement;
  import flashx.textLayout.elements.LinkElement;
  import flashx.textLayout.elements.ParagraphElement;
  import flashx.textLayout.elements.SpanElement;
  import flashx.textLayout.events.FlowElementMouseEvent;
  import flashx.textLayout.formats.TextDecoration;
  import flashx.textLayout.formats.TextLayoutFormat;

  public class RichTextField extends Sprite implements IRichTextField {
    private const MAX:int = 200;

    private var _pool:Vector.<ParagraphElement> = new <ParagraphElement>[];
    private var _spans:Vector.<SpanElement> = new <SpanElement>[];
    private var _graphics:Vector.<InlineGraphicElement> = new <InlineGraphicElement>[];
    private var _link:Vector.<LinkElement> = new <LinkElement>[];
    private var _core:TLFTextField;
    private var _text:String = "";
    private var _buffer:Array = [];
    private var _w:int = 0;
    private var _h:int = 0;
    /*onLink(id:String)
     * */
    private var _onLink:Function = null;

    public function RichTextField() {
      super();
      initInstance();
    }

    private function initInstance():void {
      _core = new TLFTextField();

      _core.textFlow.lineHeight = 30;
      var format : TextLayoutFormat = new TextLayoutFormat();
      format.fontSize = 14;
      format.fontFamily = "微软雅黑,宋体";
      this._core.textFlow.format = format;
//      _core.autoSize = TextFieldAutoSize.LEFT;
//      _core.wordWrap =true;
      this._core.textFlow.alignmentBaseline = TextBaseline.IDEOGRAPHIC_BOTTOM;
      this._core.textFlow.dominantBaseline = TextBaseline.IDEOGRAPHIC_BOTTOM;
      this.addChild(_core);
      var p:ParagraphElement = this._core.textFlow.getChildAt(0) as ParagraphElement;
      if(p!=null){
        _pool.push(p);
      }
    }

    private function build(arr:Vector.<IRichElement>):void {
      var p:ParagraphElement = createParagraph();
      for each(var ele:IRichElement in arr) {
        buildEle(p, ele);
      }
      if(this._core.textFlow.getChildIndex(p)<0) {
        this._core.textFlow.addChild(p);
      }
      check();
    }

    private function check():void {
      if(this._core.textFlow.numChildren>MAX){
       var p:FlowElement = this._core.textFlow.removeChildAt(0);
        if(p is ParagraphElement){
          _pool.push(p);
          while((p as ParagraphElement).numChildren>0){
            (p as ParagraphElement).removeChildAt(0);
          }
        }
        check();
      }
    }

    private function buildEle(p:ParagraphElement, ele:IRichElement):void {
      switch (ele.type) {
        case "g":
          buildGraphics(p, ele);
          break;
        case "l":
          buildLink(p, ele)
          break;
        default :
          var span:SpanElement = createSpan();
          span.text = String(ele.content);
          span.id = ele.id;
          p.addChild(span);
          break;
      }
    }

    private function buildLink(p:ParagraphElement, ele:IRichElement):void {
      var l:LinkElement = createLink();
      var span:SpanElement = createSpan();
      span.text = String(ele.content);
      l.addChild(span);
      l.id = ele.id;
      l.addEventListener(FlowElementMouseEvent.CLICK, onClick);
      span.textDecoration = TextDecoration.NONE;
      l.textDecoration = TextDecoration.NONE;
      p.addChild(l);
      if(ele.tf!=null){
        span.color = ele.tf.color;
      }
    }

    private function onClick(event:FlowElementMouseEvent):void {
      var id:String = event.flowElement.id;
      if (event.cancelable) {
        event.preventDefault();
      }
      if (this._onLink != null) {
        this._onLink(id);
      }
    }

    private function buildGraphics(p:ParagraphElement, ele:IRichElement):void {
      var g:InlineGraphicElement;
      if ((_core.textFlow.interactionManager as EditManager)) {
        trace("insert g 1 : "+this._core.firstBaselineOffset)
        g = (_core.textFlow.interactionManager as EditManager).insertInlineGraphic(ele.content, "100%", "100%");
        trace("insert g 2 : "+this._core.firstBaselineOffset)
      } else {
        g = createGraphics();
        p.addChild(g);
      }
      if(g!= null) {
        g.alignmentBaseline = TextBaseline.IDEOGRAPHIC_BOTTOM;
        g.dominantBaseline = TextBaseline.IDEOGRAPHIC_BOTTOM;
        g.source = ele.content as DisplayObject;
        g.id = ele.id;
      }else{
        trace("RichTextField insert null graphics"  );
      }
    }

    private function createParagraph():ParagraphElement {
      var result:ParagraphElement;
      result = this._pool.pop();
      if (result == null) {
        result = new ParagraphElement();
      }
      return result;
    }

    private function getLastParagraph():ParagraphElement {
      var result:ParagraphElement;
      var len = _core.textFlow.numChildren;
      while (len - 1 >= 0) {
        result = _core.textFlow.getChildAt(len - 1) as ParagraphElement;
        len--;
        if (result != null) {
          break;
        }
      }
      return result;
    }

    private function createSpan():SpanElement {
      var result:SpanElement;
      result = this._spans.pop();
      if (result == null) {
        result = new SpanElement();
      }
      return result;
    }

    private function createGraphics():InlineGraphicElement {
      var result:InlineGraphicElement;
      result = this._graphics.pop();
      if (result == null) {
        result = new InlineGraphicElement();
      }
      return result;
    }

    private function parseParagraph(p:ParagraphElement):String {
      var result:String = "";
      var len:int = p.numChildren;
      var ele:FlowElement;
      var str:String = "";
      for (var i:int = 0; i < len; i++) {
        ele = p.getChildAt(i);
        if (ele is SpanElement) {
          str = (ele as SpanElement).text;
        } else if (ele is LinkElement) {
          var l:LinkElement = (ele as LinkElement);
          str = "[l:" + (l.getChildAt(0) as SpanElement).text + "]";
        } else if (ele is InlineGraphicElement) {
          var g:InlineGraphicElement = (ele as InlineGraphicElement);
          str = "[g:" + ele.id + "]";
        }
        result += str;
      }
      return result;
    }

    public function createLink():LinkElement {
      var result:LinkElement;
      result = this._link.pop();
      if (result == null) {
        result = new LinkElement();
      }
      return result;
    }


    override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      this._core.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      this._core.removeEventListener(type, listener, useCapture);
    }

    public function render():void {
      if (this._core.textFlow != null) {
        this._core.textFlow.flowComposer.updateAllControllers();
      }
    }

    public function editable(value:Boolean):void {
      if (value) {
        _core.textFlow.interactionManager = new EditManager();
      } else {
        _core.textFlow.interactionManager = new SelectionManager();
      }
    }

    public function selectable(value:Boolean):void {
      if (value) {
        _core.textFlow.interactionManager = new SelectionManager();
      } else {
        _core.textFlow.interactionManager = null;
      }
    }

    public function getSpan(content:String, id:String):IRichElement {
      var result:IRichElement = new RichElement();
      result.id = id;
      result.content = content;
      result.type = "s";
      return result;
    }

    public function getLink(content:String, id:String):IRichElement {
      var result:RichElement = new RichElement();
      result.id = id;
      result.content = content;
      result.type = "l";
      return result;
    }

    public function getGraphics(content:DisplayObject, id:String):IRichElement {
      var result:RichElement = new RichElement();
      result.id = id;
      result.content = content;
      result.type = "g";
      return result;
    }

    public function setFocus():void {
      this._core.textFlow.interactionManager.setFocus();
      this._core.textFlow.interactionManager.selectRange(this._core.text.length, this._core.text.length);
      trace("set focus");
    }

    public function appendParagraph(arr:Vector.<IRichElement>):void {
      this.build(arr);
    }

    public function get richText():String {
      var tmp:String = "";
      var len:int = _core.textFlow.numChildren;
      var p:FlowElement;
      for (var i:int = 0; i < len; i++) {
        p = this._core.textFlow.getChildAt(i);
        if (p is ParagraphElement) {
          var str:String = parseParagraph(p as ParagraphElement);
          tmp += str;
        }
      }
//      _text = tmp;
      trace(" get rich xml " + this._core.tlfMarkup );
      return tmp;
    }

    public function set richText(value:String):void {
//      _text = value;
      this._core.text = value;
      trace("rich xml " + this._core.tlfMarkup + " text : "+this._core.text );
    }

    public function dispose():void {

    }

    public function get scrollV():int {
      return _core.scrollV;
    }

    public function set scrollV(value:int):void {
      _core.scrollV = value;
    }

    public function get maxScrollV():int {
      return _core.maxScrollV;
    }

    public function get pixelScrollV():int {
      return _core.pixelScrollV;
    }

    public function set pixelScrollV(value:int):void {
      _core.pixelScrollV = value;
    }

    public function get pixelMaxScrollV():int {
      return _core.pixelMaxScrollV;
    }

    public function set onLink(onLink:Function):void {
      this._onLink = onLink;
    }

    public function append(param:Vector.<IRichElement>):void {
      var p:ParagraphElement = getLastParagraph();
      for each(var ele:IRichElement in param) {
        buildEle(p, ele);
      }
    }

    public function setInput(flag:Boolean):void {
      if (flag) {
        this._core.textFlow.interactionManager = new EditManager();
      }
    }

    public function setSelectable(flag:Boolean):void {
      if (flag) {
        this._core.textFlow.interactionManager = new SelectionManager();
      } else {
        this._core.textFlow.interactionManager = null;
      }
    }

    public function resize(w:int, h:int):void {
      this._w = w;
      this._h = h;
      this._core.width = w;
      this._core.height = h;
      if (this._core.textFlow != null) {
        this._core.textFlow.flowComposer.updateAllControllers();
      }
      trace("rich tf h " + h + " | " + this._core.height);
//      trace("rich tf this h " + h + " | "+this.height);
    }

    public function setFormat(tf:TextFormat) {
      this._core.textColor = uint(tf.color);
//      this._core.setTextFormat(tf);
    }

    public function setBg(flag:Boolean, color:uint, alpha:Number):void {
      this._core.background = flag;
      this._core.backgroundColor = color;
      this._core.backgroundAlpha = alpha;
    }

    public function setMultiline(flag:Boolean):void {
      this._core.multiline = flag;
    }

    public function get wordWrap():Boolean {
      return this._core.wordWrap;
    }

    public function set wordWrap(value:Boolean):void {
      this._core.wordWrap = value;
    }
    public function autoSize(param:String):void{
      if(param !=null && param.length>0){
        this._core.autoSize = param;
      }else{
        this._core.autoSize = TextFieldAutoSize.NONE;
      }
    }

    public function get textWidth():int {
      return this._core.textWidth;
    }

    public function get textHeight():int {
      return this._core.textHeight;
    }
  }
}
