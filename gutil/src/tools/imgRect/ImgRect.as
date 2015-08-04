/**
 * Created by wbguan on 2015/8/4.
 */
package tools.imgRect {
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.ui.Keyboard;

  import util.ui.shape.LRCircle;

  import util.ui.unity.LRButton;
  [SWF(width = 600,height = 500,backgroundColor = 0xffffff)]
  public class ImgRect extends Sprite {
    private var _loadBtn:LRButton;
    private var _resetBtn:LRButton;
    private var _rTxt:TextField;
    private var _exportBtn:LRButton;
    private var _current:ImgCircle;
    private var _getBtn:LRButton;
    private const COLOR:uint = 0x0099FF;
    private var circle:LRCircle;
    private var _imgModel:ImgRectModel;

    public function ImgRect() {
      super();
      initInstance();
      initListener();
      this.addChild(new LRCircle(10,COLOR,0.5));
    }

    private function initInstance():void{
      _imgModel = new ImgRectModel();
      _loadBtn = new LRButton("load");
      _resetBtn = new LRButton("reset");
      _exportBtn = new LRButton("export");
      _getBtn = new LRButton("get");
      _rTxt = new TextField();
      _rTxt.autoSize = TextFieldAutoSize.LEFT;
      _rTxt.width = 100;
      _rTxt.height = 20;
      _rTxt.type = TextFieldType.INPUT;
      _rTxt.background = true;
      _rTxt.backgroundColor = 0xcccccc;
      _rTxt.restrict = "0-9";
      this.addChild(_loadBtn);
      this.addChild(_resetBtn);
      this.addChild(_exportBtn);
      this.addChild(_getBtn);
      this.addChild(_rTxt);
      _resetBtn.x = 50;
      _exportBtn.x = 100;
      _rTxt.x = 400;
      _getBtn.x = 500;
    }
    private function initListener():void{
      _rTxt.addEventListener(KeyboardEvent.KEY_UP, onFocusOut);
      _rTxt.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
      _getBtn.addEventListener(MouseEvent.CLICK, onGet);
      _resetBtn.addEventListener(MouseEvent.CLICK, onReset);
      _exportBtn.addEventListener(MouseEvent.CLICK, onExport);
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded)
    }

    private function onAdded(event:Event):void {
      this.stage.scaleMode = StageScaleMode.NO_SCALE;
      this.stage.align = StageAlign.TOP_LEFT;
      this.stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
    }

    private function onStageKeyUp(event:KeyboardEvent):void {
      if(event.charCode == Keyboard.DELETE){
        if(this._current != null){
          var index:int = this._imgModel.circles.indexOf(this._current);
          if(index>=0){
            this._imgModel.circles.splice(index,1);
          }
          if(this.contains(_current)){
            this.removeChild(_current);
          }
          _current = null;
        }
      }
    }

    private function onExport(event:MouseEvent):void {

    }

    private function onReset(event:MouseEvent):void {

    }

    private function onFocusOut(event:Event):void {
      var r:int = int(_rTxt.text);
      if(r>0) {
        if(circle!=null&&this.contains(circle)){
          this.removeChild(circle);
        }
        circle = new LRCircle(r,COLOR,0.1);
        this.addChild(circle);
        circle.x = 400;
        circle.y = int((500 - circle.height)/2)+r;
      }
    }

    private function onFocusIn(event:FocusEvent):void {
//      _rTxt.text = "";
    }

    private function onGet(event:MouseEvent):void {
      var imgC:ImgCircle = new ImgCircle();
      var c:LRCircle = new LRCircle(circle.radius,COLOR,0.5);
      imgC.setCircle(c);
      imgC.addEventListener(MouseEvent.CLICK, onImgClick);
      this.addChild(imgC);
      imgC.x = 200+int(Math.random()*10);
      imgC.y = 200+int(Math.random()*10);
      this._imgModel.circles.push(imgC);
    }

    private function onImgClick(event:MouseEvent):void {
      var target:ImgCircle = event.currentTarget as ImgCircle;
      if(_current!=null){
        _current.unSelect();
      }
      if(target!=null){
        _current = target;
        _current.select();
      }
    }

  }
}
