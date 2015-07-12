package util.ui.unity {
  
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;


  import util.txt.TextUtil;

  /**
   * @author wbguan
   */
  public class LRPopo extends Sprite {
    private var _mc:Sprite;
    private var _max:int;
    private var _txt:TextField;
    
    public function LRPopo(mc:MovieClip,max:int = 99,autoFont:Boolean = true) {
      this._mc = mc;
      this._max = max;
      this.addChild(_mc);
      if(mc.hasOwnProperty("txt")){
        this._txt = mc["txt"] as TextField;
      }else{
        this._txt = new TextField();
        this._txt.autoSize = TextFieldAutoSize.CENTER;
        this.addChild(this._txt);
      }
      if(autoFont){
        TextUtil.formatYaHei(this._txt);
      }
    }
    
    public function setNum(num:int,format:TextFormat = null):void{
      var er:String = "";
      if(num > _max){
        num = _max;
        er = "+";
      }
      this._txt.text = num + er;
      if(format != null){
        this._txt.setTextFormat(format);
      }
    }
    
    public function setStr(str:String,format:TextFormat = null):void{
      this._txt.text = str;
      if(format != null){
        this._txt.setTextFormat(format);
      }
    }

    public function clear():void {
      this._txt.text = "";
    }
    
  }
}
