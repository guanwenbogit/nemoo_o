/**
 * Created by wbguan on 2015/5/19.
 */
package bobo.modules.chat {
  import com.plugin.richTxt.IRichElement;
  import com.plugin.richTxt.IRichImgMapping;
  import com.plugin.richTxt.IRichTextField;
  import com.util.reflect.ReflectionUtil;
  import com.plugin.richTxt.RichTxt;


  import flash.display.Sprite;
  import flash.text.TextFormat;

  public class OutputTxt extends Sprite {
    private var _core:RichTxt;
    private var _w:int = 0;
    private var _h:int = 0;

    public function OutputTxt(w:int,h:int) {
      super();
      _w = w;
      _h = h;
      initInstance();
    }
    public function init():void{
      _core.init(null,ReflectionUtil.getObj("com.plugin.richTxt.RichTextField") as IRichTextField);
      this.addChild(_core);
      _core.inputAble(false);
      _core.setBg(false,0x654321);
      _core.setMultiline(true);
      _core.setWrap(true);
      _core.resize(_w,_h);
      _core.selectable(false);
    }
    public function get textWidth():int{
      return this._core.textWidth;
    }
    public function get textHeight():int{
      return this._core.textHeight;
    }
    public function setMapping(map:IRichImgMapping):void{
      _core.setMapping(map);
    }
    public function setFormat(tf:TextFormat):void{
      _core.setFormat(tf);
    }
    private function initInstance():void{
      _core = new RichTxt()
    }
    private function setVars():void{

    }

    public function appendTxt(param:String):void{
      _core.appendTxt(param);
    }

    public function render():void {
      _core.render()
    }

    public function appendParagraph(arr:Vector.<IRichElement>):void {
      _core.appendParagraph(arr);
//      _core.inputAble(false);
//      _core.selectable(false);

    }
    public function resize(w:int,h:int):void{
      _core.resize(w,h);
    }

    public function setRate(rate:Number):void {
      var max:int = maxPixelV();
      var v:int = Math.ceil(max*rate);
      this._core.pixelScrollV = v;
    }
    public function needBar():Boolean{
      return _core.maxPixelV>0;
    }
    public function maxPixelV():int{
      return _core.maxPixelV
    }
    public function autoSize(param:String):void{
      this._core.autoSize(param);
    }

    public function clearTxt():void {
      _core.text = "";
      this._core.inputAble(false);
      this._core.selectable(false);
    }
  }
}
