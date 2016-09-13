/**
 * Created by wbguan on 2015/6/16.
 */
package com.util.ui.scrollbar {

  import com.util.ui.unity.BaseBtn;

  import flash.display.DisplayObject;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.geom.Rectangle;



  public class LRScrollerBar extends LRScrollerBase {
    private var _isV:Boolean = true;
    private var wh:String = "";
    private var xy:String = "";
    public function LRScrollerBar(bar:BaseBtn, bg:DisplayObject, distance:Number, scaleBar:Boolean = true, isV:Boolean = true) {
      _isV = isV;
      super(bar, bg, distance, scaleBar);
      this.buttonMode = true;
    }

    override protected function initInstance():void {
      setDirect();
      this._bar.x = this._bar.y = 0;
      this._scrollBarOriginalPoint = new Point(this._bar.x,this._bar.y);
      this._bg[wh] = this._distance;
      if(_scaleBar) {
        this._bar.height = this._distance;
      }
      var w:int = 0;
      var h:int = 0;
      if(_isV){
        h = this._bg.getRect(this).height - this._bar.getRect(this).height;
      }else{
        w = this._bg.getRect(this).width - this._bar.getRect(this).width;
      }
      this._rectangle = new Rectangle(this._scrollBarOriginalPoint.x,this._scrollBarOriginalPoint.y,w,h);
      this._orginalRectangle = this._rectangle.clone();
      this.addEventListener(MouseEvent.CLICK, onSelfClick)
    }

    private function onSelfClick(event:MouseEvent):void {
      var target:DisplayObject = event.target as DisplayObject;
      if(target != _bar && !_bar.contains(target)){
        var ds:int = 0;
        if(_isV){
          ds = this.mouseY;
        }else {
          ds = this.mouseX;
        }
        var rate:Number = 1.0*ds/distance;
        this.rate = rate;
      }
    }


    override public function appendBarPosition(param:int):void {
      this._bar[xy] +=param;
      judgeBoundary();
      calculateRate();
      callBack();
    }

    override protected function calculateRate():void {
      this._rate = (this._bar[xy] - this._scrollBarOriginalPoint[xy])/(this._distance * this._scale- this._bar[wh]);
      if(1 - this._rate < 0.01){
        this._rate = 1;
        this.dispatchEvent(new LRScrollerEvent(LRScrollerEvent.END_EVENT));
      }
    }

    override protected function setRate():void {
      this._bar[xy] = (this._distance * this._scale - this._bar[wh]) * this._rate + this._scrollBarOriginalPoint[xy];
      judgeBoundary();
      if(1 - this._rate < 0.01){
        this._rate = 1;
        this.dispatchEvent(new LRScrollerEvent(LRScrollerEvent.END_EVENT));
      }
      callBack();
    }

    private function setDirect():void{
      if(_isV){
        wh = "height";
        xy = "y";
      }else{
        wh = "width";
        xy = "x";
      }
    }

  }
}
