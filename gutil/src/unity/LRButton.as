package unity {


import Interface.IDispose;

import flash.display.Bitmap;
  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.SimpleButton;
  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

import gshape.LRRoundRectangle;

/**
   * @author wbguan
   */
  public class LRButton extends Sprite implements IDispose {
    protected var upState : String = "up";
    protected var downState : String = "down";
    protected var overState : String = "over";
    protected var _bg : DisplayObject;
    protected var _labelStr : String = "";
    protected var _txt : TextField;
    protected var _toolTip:String;
    protected var _toolTxt:TextField;
    private const margin : Number = 5;
    private var _isDown:Boolean = false;
    /*
     * if the displayObj is the MovieClip,the mc must contain 3 frames which named "down" , "up" , "over";
     * if the mc had a textfield inside which was named "label" ,the instance will use the textfield of mc instead of the default one. 
     */
    public function LRButton(text : String = "undefine", displayObj : DisplayObject = null) {
      this._labelStr = text;
      if (displayObj != null) {
        this._bg = displayObj;
        this.switchBg();
      } 
      this.init();
      this.addChildAt(this._bg, 0);
    }

    private function switchBg() : void {
      if (this._bg is SimpleButton) {
      } else if (this._bg is MovieClip) {
        (this._bg as MovieClip).stop();
        (this._bg as MovieClip).mouseChildren = false;
        if (this._bg.hasOwnProperty("label")) {
          this._txt = this._bg["label"] as TextField;
        }
        this.initMCListener();
      } else if (this._bg is Bitmap) {
      }
    }

    private function initMCListener() : void {
      if (!this.hasEventListener(MouseEvent.MOUSE_DOWN)) {
        this.addEventListener(MouseEvent.MOUSE_DOWN, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_UP)) {
        this.addEventListener(MouseEvent.MOUSE_UP, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_OVER)) {
        this.addEventListener(MouseEvent.MOUSE_OVER, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_OUT)) {
        this.addEventListener(MouseEvent.MOUSE_OUT, onMcMouseHandler);
      }
    }

    private function initTextField() : void {
      var format : TextFormat = new TextFormat();
      this._txt = new LRTextField();
      if(this._labelStr == "undefine"){
        this._txt.htmlText = "Button";
      }
      this._txt.x = this._txt.y = this.margin;
      this.addChild(this._txt);
      this._txt.mouseEnabled = false;
      format.size = 20;
      this._txt.setTextFormat(format);
    }
    
    private function defaultBg():void{
      this._bg = new LRRoundRectangle(this._txt.width + 2 * this.margin, this._txt.height + 2 * this.margin, 5);
      this.bg = this._bg;
    }
      

    private function init() : void {
      this.useHandCursor = true;
      this.buttonMode = true;
      if(this._txt == null ){
        this.initTextField();
      }
      if(this._labelStr != "undefine"){
        this._txt.htmlText = this._labelStr;
      }
      if(this._bg == null){
        this.defaultBg();
      }
    }

    private function resetLocation() : void {
      if (this._bg is LRRoundRectangle) {
        this.removeChild(this._bg);
        this._bg = new LRRoundRectangle(this._txt.width + 2 * this.margin, this._txt.height + 2 * this.margin, 5);
        this.addChildAt(this._bg, 0);
      } else {
      }
    }

    public function lockState() : void {
      this.removeMcListener();
    }

    public function unlockState() : void {
      this.addMcListener();
      this._isDown = false;
    }

    private function removeMcListener() : void {
      this.removeEventListener(MouseEvent.MOUSE_OVER, onMcMouseHandler);
      this.removeEventListener(MouseEvent.MOUSE_UP, onMcMouseHandler);
      this.removeEventListener(MouseEvent.MOUSE_OUT, onMcMouseHandler);
      this.removeEventListener(MouseEvent.MOUSE_DOWN, onMcMouseHandler);
    }

    private function addMcListener() : void {
      if (!this.hasEventListener(MouseEvent.MOUSE_DOWN)) {
        this.addEventListener(MouseEvent.MOUSE_DOWN, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_UP)) {
        this.addEventListener(MouseEvent.MOUSE_UP, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_OVER)) {
        this.addEventListener(MouseEvent.MOUSE_OVER, onMcMouseHandler);
      }
      if (!this.hasEventListener(MouseEvent.MOUSE_OUT)) {
        this.addEventListener(MouseEvent.MOUSE_OUT, onMcMouseHandler);
      }
    }
    public function setScale9Width(width:Number):void{
      this._bg.width = width;
    }
    public function setScale9Height(height:Number):void{
      this._bg.height = height;
    }
    
    public function  setMouseOver() : void {
      if(this._bg is MovieClip){
        (this._bg as MovieClip).gotoAndStop(this.overState);
        var tf:TextField = _bg["label"] as TextField;
        if (tf) {
          tf.text = _labelStr;
        }
      }
      this._isDown = false;
    }

    public function setMouseDown() : void {
      if(this._bg is MovieClip){
        (this._bg as MovieClip).gotoAndStop(this.downState);
        var tf:TextField = _bg["label"] as TextField;
        if (tf) {
          tf.text = _labelStr;
        }
      }
      this._isDown = true;
    }

    public function setMouseUp() : void {
      if(this._bg is MovieClip){
        (this._bg as MovieClip).gotoAndStop(this.upState);
        var tf:TextField = _bg["label"] as TextField;
        if (tf) {
          tf.text = _labelStr;
        }
      }
      this._isDown = false;
    }

    public function setLabel(value:String,autoSize:Boolean = true):void{
      this._txt.text = value;
      _labelStr = value;
      this.resetLocation();
    }

    public function set label(value : String) : void {
      this._txt.text = value;
      this.resetLocation();
    }

    public function get bg() : DisplayObject {
      return this._bg;
    }

    public function set bg(value : DisplayObject) : void {
      if (this.contains(this._bg)) {
        this.removeChild(this._bg);
      }
      this._bg = value;
      this.addChildAt(this._bg, 0);
      this.switchBg();
    }

    public function get textfield() : TextField {
      return this._txt;
    }

    private function onMcMouseHandler(event : MouseEvent) : void {
      switch(event.type) {
        case MouseEvent.MOUSE_DOWN:
          this.setMouseDown();
          break;
        case MouseEvent.MOUSE_OVER:
          this.setMouseOver();
          break;
        case MouseEvent.MOUSE_OUT:
        case MouseEvent.MOUSE_UP:
          this.setMouseUp();
          break;
      }
    }

    public function enableToolTip():void{
      if (!this.hasEventListener(MouseEvent.ROLL_OUT)) {
        this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
      }
      if(!this.hasEventListener(MouseEvent.ROLL_OVER)){
        this.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
      }
      if(!this.hasEventListener(MouseEvent.CLICK)){
        this.addEventListener(MouseEvent.CLICK, onRollOut);
      }
      _toolTxt = new TextField();
      _toolTxt.autoSize = TextFieldAutoSize.CENTER;
      _toolTxt.background = true;
      _toolTxt.backgroundColor = 0xffffff;
      _toolTxt.defaultTextFormat = new TextFormat("微软雅黑",12);
    }
    public function unableToolTip():void{
      if(this.hasEventListener(MouseEvent.ROLL_OUT)) {
        this.removeEventListener(MouseEvent.ROLL_OUT, onRollOut);
      }
      if(this.hasEventListener(MouseEvent.ROLL_OVER)){
        this.removeEventListener(MouseEvent.ROLL_OVER, onRollOver);
      }
      if(!this.hasEventListener(MouseEvent.CLICK)){
        this.removeEventListener(MouseEvent.CLICK, onRollOut);
      }
    }
    public function setToolTip(content:String):void{
      this._toolTip = content;
      this._toolTxt.text = content;
    }

    protected function onRollOver(event : MouseEvent) : void {
      this._toolTxt.x = this.width + 5;
      this._toolTxt.y = this.height / 2;
      if(!this.contains(this._toolTxt)){
        this.addChild(this._toolTxt);
      }
    }

    protected function onRollOut(event : MouseEvent) : void {
      if(this.contains(this._toolTxt)){
        this.removeChild(this._toolTxt);
      }
    }

    public function dispose():void {
    }

    public function get isDown():Boolean {
      return _isDown;
    }
  }
}
