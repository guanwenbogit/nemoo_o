package com.util.ui.scrollbar {

  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.events.MouseEvent;
  import flash.display.Stage;
  import flash.events.Event;
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  import com.util.ui.unity.BaseBtn;



  /**
   * @author wbguan
   */
  public class LRScrollerBase extends Sprite {
    //==========================================================================
    //  display object
    //==========================================================================
    protected var _bar:BaseBtn;
    protected var _bg:DisplayObject;
    protected var _appStage:Stage;
    protected var _barGrid:Rectangle;
    protected var _rectangle : Rectangle;
    protected var _distanceX : Number;
    protected var _distanceY : Number;
    protected var _scrollBarOriginalPoint:Point;
    protected var _rate:Number = 0;
    protected var _distance:Number;
    protected var _scale:Number = 1;
    protected var _orginalRectangle:Rectangle;
    protected var _isHold:Boolean = false;
    protected var _scaleBar:Boolean = false;
  //==========================================================================
  //  handler
  //==========================================================================
    public var onScolling:Function;
    
    public function LRScrollerBase(bar:BaseBtn,bg:DisplayObject,distance:Number,scaleBar:Boolean = true) {
      this._bar = bar;
      this._bg = bg;
      this._distance = distance;
      _scaleBar = scaleBar;
      this.initInstance();
      this.addToParent();
      this.initListener();
    }
    
    protected function initInstance():void {
      this._bar.x = this._bar.y = 0;
      this._scrollBarOriginalPoint = new Point(this._bar.x,this._bar.y);
      this._bg.height = this._distance;
      if(_scaleBar) {
        this._bar.height = this._distance;
      }
      this._rectangle = new Rectangle(this._scrollBarOriginalPoint.x,this._scrollBarOriginalPoint.y,0,this._bg.getRect(this).height - this._bar.getRect(this).height);
      this._orginalRectangle = this._rectangle.clone();
    }
    
    private function addToParent():void{
      this.addChild(this._bg);
      this.addChild(this._bar);
    }
    
    protected function initListener() : void {
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onBarMouseDown(event : MouseEvent) : void {
      this._isHold = true;
      this._distanceX = this._bar.x - this.mouseX;
      this._distanceY = this._bar.y - this.mouseY;
      this._appStage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
    }
    
    public function appendBarPosition(param:int):void{
      this._bar.y +=param;
      trace("[LRScrollerBase/appendBarY]" +this._bar.y);
      judgeBoundary();
      calculateRate();
      callBack();
    }
    
    private function onStageMouseMove(event : MouseEvent) : void {
      this._bar.x = this._distanceX + this.mouseX;
      this._bar.y = this._distanceY + this.mouseY;
//      trace("[LRScrollerBase/onStageMouseMove] " + this._bar.y);
      judgeBoundary();
      calculateRate();

      callBack();
    }

    protected function calculateRate():void{
//      trace("[LRScrollerBase/calculateRate] dis : " + this._distance * this._scale + " | " + this._distance);
//      trace("[LRScrollerBase/calculateRate] bar h : " + this._bar.height);
//      trace("[LRScrollerBase/calculateRate] y :"+ this._bar.y);
//      trace("[LRScrollerBase/calculateRate] " +(this._bar.y - this._scrollBarOriginalPoint.y));
//      trace("[LRScrollerBase/calculateRate] " +(this._distance * this._scale- this._bar.height));
      this._rate = (this._bar.y - this._scrollBarOriginalPoint.y)/(this._distance * this._scale- this._bar.height);
//      trace("[LRScrollerBase/calculateRate] rate : " + rate);
      if(1 - this._rate < 0.01){
        this._rate = 1;
        this.dispatchEvent(new LRScrollerEvent(LRScrollerEvent.END_EVENT));
      }
    }

    private function onAdded(event : Event) : void {
      this._appStage = this.stage;
      initStageListener();
      initOtherListener();
    }

    private function onMouseUp(event : *) : void {
      this._appStage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
      if(this._isHold){
        this._isHold = false;
        this.dispatchEvent(new LRScrollerEvent(LRScrollerEvent.BAR_UP));  
      }
    }
    
    protected function initStageListener():void {
      this._appStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this._appStage.addEventListener(Event.MOUSE_LEAVE, onMouseUp);
    }
    protected function initOtherListener():void{
      this._bar.addEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
      this._bar.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }
    protected function judgeBoundary() : void {
      if (this._bar.x < this._rectangle.x) {
        this._bar.x = this._rectangle.x;
      }
      if (this._bar.x > this._rectangle.right) {
        this._bar.x = this._rectangle.right;
      }
      if (this._bar.y < this._rectangle.y) {
        this._bar.y = this._rectangle.y;
      }
      if (this._bar.y > this._rectangle.bottom) {
        this._bar.y = this._rectangle.bottom;
//        trace("[LRScrollerBase/judgeBoundary] bar y: " + this._bar.y);
//        trace("[LRScrollerBase/judgeBoundary] bottom : " +this._rectangle.bottom);
      }
//      trace("[LRScrollerBase/judgeBoundary] " + this._bar.y);
    }

    protected function setRate():void{
      this._bar.y = (this._distance * this._scale - this._bar.height) * this._rate + this._scrollBarOriginalPoint.y;
      trace("[LRScrollerBase/setRate]" + this._bar.y);
      judgeBoundary();
      if(1 - this._rate < 0.01){
        this._rate = 1;
        this.dispatchEvent(new LRScrollerEvent(LRScrollerEvent.END_EVENT));
      }
      callBack();
    }
    protected function callBack():void {
      if(this.onScolling != null){
        this.onScolling();
      }
    }
    private const MINBAR_LENGTH:Number = 15;
    public function setBarScale(scale:Number):void{
      if(_scaleBar) {
        scale = scale > 1 ? 1 : scale;
        scale = scale < 0.1 ? 0.1 : scale;
        var span:Number = this._distance * scale * this._scale < MINBAR_LENGTH ? MINBAR_LENGTH : this._distance * scale * this._scale;
        span = Math.floor(span);
        this._bar.height = span;
      }
      trace("[LRScrollerBase/setBarScale] "+this._bar.getRect(this).height+"|" + _bar.alpha + "|" + _bar.visible + "|"+_bar.parent + "|" +_bar.y);
      this._rectangle.height = this._bg.getRect(this).height - this._bar.getRect(this).height;
    }
    
    public function get rate() : Number {
      return _rate;
    }

    public function set rate(rate : Number) : void {
      if(rate >= 1){
        rate = 1;
      }
      this._rate = rate;
      setRate();
    }
    
    public function setScaleH(scale:Number,min:Number = 0.5):void{
      this._scale = scale;
      if(this._scale > 1){
        this._scale = 1;
      }
      if(this._scale < min){
        this._scale = min;
      }
      this._bg.height = this._distance * this._scale;
      this._rectangle.height = (this._bg.getRect(this).height - this._bar.getRect(this).height);
      if(this._rectangle.height <1){
        this._rectangle.height = 1;
      }
      this.rate = this._rate;
    }
    
    public function releaseBar():void {
      this._bar.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
    }
    
    public function dispose():void {
      this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
      this._appStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this._appStage.removeEventListener(Event.MOUSE_LEAVE, onMouseUp);
      this._appStage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
      this._bar.removeEventListener(MouseEvent.MOUSE_DOWN, onBarMouseDown);
      this._bar.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this.removeChild(this._bar);
      this.removeChild(this._bg);
      this._bar = null;
      this._bg = null;
      this.onScolling = null;
      this._appStage = null;
    }

    public function get isHold():Boolean {
      return _isHold;
    }

    public function get distance():Number {
      return _distance;
    }

    public function set distance(value:Number):void {
      _distance = value;
      this.initInstance();
    }
  }
}
