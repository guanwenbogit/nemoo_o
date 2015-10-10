/**
 * Created by wbguan on 2015/5/19.
 */
package bobo.plugins.druid.txt {
  import com.plugin.richTxt.IRichTextField;
  import com.util.reflect.ReflectionUtil;
  import com.plugin.richTxt.RichTxt;

  import flash.display.DisplayObject;

  import flash.display.Sprite;
  import flash.text.TextFormat;

  public class InputTxt extends Sprite {
    public function InputTxt(w:int,h:int) {
      super();
      _w = w;
      _h = h;
      initInstance();

    }
    private var _core:RichTxt;
    private var _w:int = 0;
    private var _h:int = 0;


    public function init():void{
      _core.init(null,ReflectionUtil.getObj("com.plugin.richTxt.RichTextField") as IRichTextField);
      setVars();

    }
    private function initInstance():void{
      _core = new RichTxt();
    }

    private function setVars():void{
      _core.resize(_w,_h);
//      _core.setBg(true,0x123456);
      _core.inputAble(true);
      _core.setMultiline(false);
      _core.setWrap(false);
      this.addChild(_core);
    }
    public function appendGraphics(id:String,obj:DisplayObject):void{
      _core.appendGraphics(id,obj);
    }
    public function appendTxt(param:String):void{
      _core.appendTxt(param);
    }
    public function clearTxt():void{
      _core.text = "";
      trace("input txt " + _core.text);
      _core.inputAble(true);
      _core.setMultiline(false);
      _core.setWrap(false);
      _core.setFocus();
    }
    public function get text():String {
      return _core.text;
    }

    public function render():void {
      _core.render();
      _core.setFocus();
//      _core.pixelScrollV = _core.maxPixelV;
    }

    public function setFormat(sysTF:TextFormat):void {
      _core.setFormat(sysTF);
    }

    public function setFocus():void {
      _core.setFocus();
    }
  }
}
