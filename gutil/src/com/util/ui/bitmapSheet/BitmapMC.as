/**
 * Created by wbguan on 2015/3/9.
 */
package com.util.ui.bitmapSheet {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.geom.Rectangle;

  public class BitmapMC extends Sprite {
    private var _bitmaps:Vector.<BitmapData> = new <BitmapData>[];
    private var _bitMap:Bitmap = new Bitmap();
    private var _w:int ;
    private var _h:int ;
    private var _frame:int = 0;
    private var _len:int = 0;
    public function BitmapMC(bitmapDataArr:Vector.<BitmapData>,w:int = 0,h:int = 0) {
      super();
      _len = bitmapDataArr.length;
      for each(var bitmap:BitmapData in bitmapDataArr){
        this._bitmaps.push(bitmap);
      }
      this.addChild(this._bitMap);
      this._w = w;
      this._h = h;
    }
    public function play():void{
      this._frame = 0;
      this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function onEnterFrame(event:Event):void {
      if(_frame < _len){
        var tmp:BitmapData = _bitmaps[_frame];
        this._bitMap.bitmapData = tmp;
        _frame++;
      }else{
        stop();
        this.dispatchEvent(new Event(Event.COMPLETE));
      }
    }

    public function stop():void{
      this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    public function get w():int {
      return _w;
    }

    public function get h():int {
      return _h;
    }

    public function get frame():int {
      return _frame;
    }

    public function get len():int {
      return _len;
    }

    public function dispose():void {
      _bitMap = null;
      while(this.numChildren > 0){
        this.removeChildAt(0);
      }
      while(this._bitmaps.length>0){
        this._bitmaps.pop();
      }
      this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
    }
  }
}
