/**
 * Created by wbguan on 2015/5/25.
 */
package com.util.label {
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public class LRLabel extends Sprite {
    private var _key:TextField;
    private var _value:TextField;
    private var _align:LRAlignLabel;
    public function LRLabel(w:int = 0,align:String = "left") {
      super();
      initInstance(w,align);
    }
    private function initInstance(w:int, align:String):void {
      _key = new TextField();
      _value = new TextField();
      _value.autoSize = _key.autoSize = TextFieldAutoSize.LEFT;
      this.addChild(this._key);
      this.addChild(this._value);
      _align = new LRAlignLabel(w,align);
      _align.setKey(_key);
      _align.setValue(_value);
      _key.mouseEnabled = _value.mouseEnabled = false;
    }
    protected function render():void{
      var max:int = _key.textHeight>_value.textHeight?_key.textHeight:_value.textHeight;
      _key.y = int((max - _key.textHeight)/2);
      _value.y = int((max - _value.textHeight)/2);
      _align.render();
    }
    public function setKey(param:String,format:TextFormat=null):void{
      _key.text = param;
      if(format!=null){
        _key.setTextFormat(format);
        _key.defaultTextFormat = format;
      }else{

      }
      render();
    }
    public function setValue(param:String,format:TextFormat=null):void{
      _value.text = param;
      if(format!=null){
        _value.setTextFormat(format);
        _value.defaultTextFormat = format;
      }
      render();
    }
  }
}
