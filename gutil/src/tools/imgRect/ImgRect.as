/**
 * Created by wbguan on 2015/8/4.
 */
package tools.imgRect {
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.KeyboardEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.net.FileFilter;
  import flash.net.FileReference;
  import flash.system.LoaderContext;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFieldType;
  import flash.ui.Keyboard;

  import com.util.ui.shape.LRCircle;

  import com.util.ui.unity.LRButton;
  [SWF(width = 600,height = 600,backgroundColor = 0xffffff)]
  public class ImgRect extends Sprite {
    private var _loadBtn:LRButton;
    private var _resetBtn:LRButton;
    private var _rTxt:TextField;
    private var _pxTxt:TextField;
    private var _pyTxt:TextField;
    private var _exportBtn:LRButton;
    private var _current:ImgCircle;
    private var _getBtn:LRButton;
    private var _p:LRCircle = new LRCircle(2,0xff0000);
    private const COLOR:uint = 0x0099FF;
    private var circle:LRCircle;
    private var _imgModel:ImgRectModel;
    private var _png:DisplayObject;
    private var _opHolder:Sprite = new Sprite();
    private var _map:Object = {
      37:new Point(-1,0),
      38:new Point(0,-1),
      39:new Point(1,0),
      40:new Point(0,1)
    };
    public function ImgRect() {
      super();
      initInstance();
      initListener();

    }

    private function initInstance():void{
      _imgModel = new ImgRectModel();
      _loadBtn = new LRButton("load");
      _resetBtn = new LRButton("reset");
      _exportBtn = new LRButton("export");
      _getBtn = new LRButton("get");
      _rTxt = new TextField();
      _pxTxt = new TextField();
      _pyTxt = new TextField();
      _rTxt.width = 100;
      _rTxt.height = 20;
      _pxTxt.type = _pyTxt.type = _rTxt.type = TextFieldType.INPUT;
      _pxTxt.background = _pyTxt.background = _rTxt.background = true;
      _pyTxt.backgroundColor = _pxTxt.backgroundColor = _rTxt.backgroundColor = 0xcccccc;
      _pxTxt.restrict = _pyTxt.restrict = _rTxt.restrict = "0-9";
      _pyTxt.width = _pxTxt.width = 50;
      _pyTxt.height = _pxTxt.height = 20;
      this.addChild(_opHolder);
      this._opHolder.addChild(_loadBtn);
      this._opHolder.addChild(_resetBtn);
      this._opHolder.addChild(_exportBtn);
      this._opHolder.addChild(_getBtn);
      this._opHolder.addChild(_rTxt);
      this._opHolder.addChild(_pxTxt);
      this._opHolder.addChild(_pyTxt);
      _pyTxt.text = "py";
      _pxTxt.text = "px";
      _resetBtn.x = 50;
      _exportBtn.x = 100;
      _rTxt.x = 400;
      _getBtn.x = 500;
      _opHolder.y = 500;
      _pxTxt.x = 400;
      _pyTxt.x = 430;
      _pyTxt.y = _pxTxt.y = 30;
    }
    private function initListener():void{
      _rTxt.addEventListener(KeyboardEvent.KEY_UP, onFocusOut);
      _rTxt.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
      _pyTxt.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
      _pxTxt.addEventListener(FocusEvent.FOCUS_IN, onFocusIn);
      _pyTxt.addEventListener(Event.CHANGE,onPChange);
      _pxTxt.addEventListener(Event.CHANGE,onPChange);
      _getBtn.addEventListener(MouseEvent.CLICK, onGet);
      _resetBtn.addEventListener(MouseEvent.CLICK, onReset);
      _exportBtn.addEventListener(MouseEvent.CLICK, onExport);
      _loadBtn.addEventListener(MouseEvent.CLICK, onLoaded);
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded)
    }

    private function onPChange(event:Event):void {
      var px:int = int(_pxTxt.text)||0;
      var py:int = int(_pyTxt.text)||0;
      _p.x = px-2;
      _p.y = py-2;
      this._imgModel.register = new Point(this._p.x,this._p.y);
    }
    private function mouseMove():void{
      this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(event:Event):void {
      if(_current!=null) {
        _current.x = this.stage.mouseX - int(_current.width / 2);
        _current.y = this.stage.mouseY - int(_current.height / 2)
      }
    }
    private function onAdded(event:Event):void {
      this.stage.scaleMode = StageScaleMode.NO_SCALE;
      this.stage.align = StageAlign.TOP_LEFT;
      this.stage.addEventListener(KeyboardEvent.KEY_UP, onStageKeyUp);
      this.stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
    }

    private function onUp(event:MouseEvent):void {
      this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onStageKeyUp(event:KeyboardEvent):void {
      if(event.keyCode == Keyboard.DELETE){
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
      }else{
        keyUpMove(event);
      }
    }
    private function keyUpMove(event:KeyboardEvent):void{
      var point:Point = _map[event.keyCode];
      var tmp:int = 1;
      if(event.shiftKey){
        tmp = 5;
      }
      if(this._current != null&&point!=null){
        this._current.x +=(point.x*tmp);
        this._current.y +=(point.y*tmp);
      }
    }

    private function onExport(event:MouseEvent):void {
      file = new FileReference();
      file.save(this._imgModel.export(),this._imgModel.name+".json");
      trace(this._imgModel.export());
    }

    private function onReset(event:MouseEvent):void {
      for each(var img:ImgCircle in this._imgModel.circles){

        img.removeEventListener(MouseEvent.MOUSE_DOWN, onImgDown);
      }
      this._imgModel.reset();
      clearLoader();
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
      var target:TextField = event.currentTarget as TextField;
      if(target!=null){
        target.text = "";
      }
    }

    private function onGet(event:MouseEvent):void {
      var imgC:ImgCircle = new ImgCircle();
      var c:LRCircle = new LRCircle(circle.radius,COLOR,0.5);
      imgC.setCircle(c);

      imgC.addEventListener(MouseEvent.MOUSE_DOWN, onImgDown);
      this.addChild(imgC);
      imgC.x = 200+int(Math.random()*10);
      imgC.y = 200+int(Math.random()*10);
      this._imgModel.circles.push(imgC);
    }

    private function onImgDown(event:MouseEvent):void {
      var target:ImgCircle = event.currentTarget as ImgCircle;
      if(_current!=null){
        _current.unSelect();
      }
      if(target!=null){
        _current = target;
        _current.select();
      }
      mouseMove();
    }

    private function onImgClick(event:MouseEvent):void {

    }
    private var file:FileReference;
    private function onLoaded(event:MouseEvent):void {
      file = new FileReference();
      var filter:Array = [new FileFilter("png file","*.png")];
      file.browse(filter);
      file.addEventListener(Event.SELECT, onSelected);
      file.addEventListener(Event.COMPLETE, onFileComplete);
    }

    private function onFileComplete(event:Event):void {
      var name:String = file.name.substr(0,file.name.lastIndexOf("."));
      var loader:Loader = new Loader()
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
      loader.loadBytes(file.data,new LoaderContext(false));
    }

    private function onLoaderComplete(event:Event):void {
      var info:LoaderInfo = event.target as LoaderInfo;
      if(this._png !=null && this.contains(this._png)){
        this.removeChild(this._png);
      }
      this._png = info.content;
      this._imgModel.name = file.name;
      this._imgModel.rect = this._png.getRect(this);
      this._imgModel.register = new Point(this._p.x,this._p.y);
      this.addChildAt(_png,0);
      this.addChild(this._p);
    }

    private function onSelected(event:Event):void {
      onReset(null);
      file.load();
    }

    private function clearLoader():void {
      if(this._png !=null && this.contains(this._png)){
        this.removeChild(this._png);
      }
      if(this._p != null && this.contains(this._p)){
        this.removeChild(_p);
        _p.y = _p.x = 0;
      }

    }

  }
}
