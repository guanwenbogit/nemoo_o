/**
 * Created by wbguan on 2015/1/22.
 */
package {
  import fl.text.TLFTextField;

  import flash.text.TextFieldType;

  import flashx.textLayout.edit.EditManager;

  import flashx.textLayout.elements.FlowElement;
  import flashx.textLayout.elements.InlineGraphicElement;
  import flashx.textLayout.elements.InlineGraphicElement;
  import flashx.textLayout.elements.LinkElement;
  import flashx.textLayout.elements.ParagraphElement;
  import flashx.textLayout.elements.SpanElement;
  import flashx.textLayout.elements.TextFlow;
  import flashx.textLayout.events.FlowElementMouseEvent;

  public class RichTextField extends TLFTextField {
    private var _graphics:RichGraphics;
    public function RichTextField(g:RichGraphics) {
      this._graphics = g;
    }

    override public function get text():String {
      var result:String = getStr();
      return result;
    }

    private function getStr():String {
      var result:String = "";
      var length : int = this.textFlow.numChildren;
      for (var i:int = 0 ;i < length;i++){
        var ele:FlowElement = this.textFlow.getChildAt(i);
        if(ele is ParagraphElement){
          var str:String = getStrFormPara(ele as ParagraphElement);
          if(i == length -1){
            result = result + str
          }else{
            result = result + str + "#p:#";
          }
        }
      }
      return result;
    }

    private function getStrFormPara(p:ParagraphElement):String {
      var result:String  = "";
      var len:int = p.numChildren;
      for(var i:int;i<len;i++){
        var ele:FlowElement = p.getChildAt(i);
        if(ele is SpanElement){
          result += (ele as SpanElement).text;
        }else if(ele is LinkElement){
          result += getLinkStr(ele as LinkElement);
        }else if(ele is InlineGraphicElement){
          result += getGraphicsStr(ele as InlineGraphicElement);
        }
      }
      return result;
    }

    private function getGraphicsStr(g:InlineGraphicElement):String {
      var result:String;
      result = "["+g.id+"]";
      return result;
    }

    private function getLinkStr(link:LinkElement):String {
      var result:String;
      result ="["+ link.id+"]";
      return result;
    }
    public function append(value:String):void{
      var p:ParagraphElement = createP(value);
      this.textFlow.addChild(p);
    }
    public function appendTxt(value:String):void{
      this.append(value);
      this.update();
    }
    public function update():void{
      this.textFlow.flowComposer.updateAllControllers();
    }
    public function insertImg(img:String):void{
      var info:GraphicsInfo = this._graphics.getInfoByStr(img);
      var len:int = this.textFlow.numChildren;
      var ele:FlowElement = this.textFlow.getChildAt(len - 1);
      if(ele is ParagraphElement && info != null && info.g != null){
        var p:ParagraphElement = ele as ParagraphElement;
        var g:InlineGraphicElement = new InlineGraphicElement();
        g.id = info.key;
        g.source = info.g;
        p.addChild(g);
        this.update();
      }
    }
    private function createP(param:String):ParagraphElement{
      var result:ParagraphElement;
      result = this.textFlow.getChildAt(0) as ParagraphElement;
      var str:String = trim(param);
      var len :int = str.length;
      var left:int = -1;
      var buffer:String = "";
      for(var i:int = 0;i<len;i++){
        var char:String = str.charAt(i);
        buffer+=char;
        if(char == "["){
          left = i;
        }else if(char == "]"){
          var key:String = str.slice(left + 1,i);
          var info:GraphicsInfo = this._graphics.getInfoByStr(key);
          if(info != null){
            var last:int = buffer.lastIndexOf("[");
            var restr:String =  buffer.slice(0,last);
            var span:SpanElement = createSpan(restr);
            result.addChild(span);
            if(info.g == null){//is a link
              var link:LinkElement = createLink(info.key,info.color);
              result.addChild(link);
            }else{
              var g:InlineGraphicElement = new InlineGraphicElement();
              g.id = info.key;
              g.source = info.g;
              result.addChild(g);
            }
            buffer = "";
            left = i;
          }
        }
      }
      if(buffer.length > 0){
        var s:SpanElement = createSpan(buffer);
        result.addChild(s);
      }
      return result;
    }
    private function createLink(param:String,color:int):LinkElement{
      var result:LinkElement;
      result = new LinkElement();
      var span:SpanElement = createSpan(param,color);
      result.addChild(result);
      result.id = param;
      result.addEventListener(FlowElementMouseEvent.CLICK, onLink);
      return result;
    }

    private function onLink(event:FlowElementMouseEvent):void {
      if(event.cancelable){
        event.preventDefault();
      }
      var target:LinkElement = event.target as LinkElement;
      this.dispatchEvent(new RichTextEvent(RichTextEvent.LINK_CLICK,target.id));
    }
    private function createSpan(param:String,color:int = -1):SpanElement{
      var result:SpanElement;
      result = new SpanElement();
      if(color>=0){
        result.color = color;
      }
      result.text = param;
      return result;
    }
    private function trim(source:String):String{
      var result:String = source;
      result = result.replace(/<br>/g,"<br />");
      return result;
    }
  }
}
