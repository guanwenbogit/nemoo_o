/**
 * Created by wbguan on 2015/4/29.
 */
package com.util.ui.scrollbar {

  import flash.display.DisplayObject;

  import com.util.ui.unity.BaseBtn;



  public class LRScrollerList extends LRScrollerPanel {
    private var _bar:LRScrollerBase;
    private var _class:Class;
    private var _params:Array;
    public function LRScrollerList(clazz:Class,w:int, h:int,barH:int,
                                   bar:BaseBtn,bg:DisplayObject,
                                   margin:int = 5, max:int = 50,scaleBar:Boolean = true,...args) {
      _bar = new LRScrollerBase(bar, bg, barH,scaleBar);
      _bar.onScolling = onScrolling;
      super(w, h, margin, max);
      _class = clazz;
      _params = args;
      this.addChild(_bar);
    }

    private function onScrolling():void {
      this.setRate(this._bar.rate);
    }
    public function appendBarY(append:int):void{
      this._bar.appendBarPosition(append);
    }
    public function setBarLocation(x:int,y:int):void{
      this._bar.x = x;
      this._bar.y = y;
    }
    public function checkBar():Boolean{
      var result:Boolean;
      this._bar.visible = (this.getSpan() > 0);
      if(this._bar.visible ){
        trace("[LRDragScrollerPanel/checkBar] " + this.getSpanScale());
        this._bar.setBarScale(this.getSpanScale());
      }
      result= this._bar.visible;
      return result;
    }
    public function setBarRate(rate:Number):void{
      this._bar.rate = rate;
    }
    override public function setRate(rate:Number):void {
      super.setRate(rate);
    }

    override public function appendData(arr:Object):void {
      super.appendData(arr);
      this.render();
      this.checkBar();
    }
    override protected function createElement():LRScrollerElement {
      var result:LRScrollerElement;
      if(_params !=null){
        result = new _class(_params);
      }else{
        result = new _class();
      }
      return result;
    }

  }
}
