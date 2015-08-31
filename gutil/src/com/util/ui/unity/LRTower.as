/**
 * Created by wbguan on 2015/2/28.
 */
package com.util.ui.unity {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.geom.Point;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.utils.getTimer;

  public class LRTower extends Sprite {
    private var _max:int = 5;
    private var _floor:int = 0;
    private var _pic:BitmapData;
    private var _margin:int;
    private var _main:Bitmap;
    private var _h:int = 0;
    private var _towerName:String = "";
    public function LRTower(pic:DisplayObject, h:int,margin:int = 0, max:int = 5) {
      _margin = margin;
      _max = max;
      checkPic(pic);
      _h = h;
      _main = new Bitmap();
      this.addChild(_main);
    }
    private function checkPic(pic:DisplayObject):void{
      if(pic !=null) {
        if (pic is Bitmap) {
          _pic = (pic as Bitmap).bitmapData;
        } else {
          _pic = new BitmapData(pic.width, pic.height, true, 0x11000000);
          _pic.draw(pic);
        }
      }
    }
    public function setPic(pic:DisplayObject,margin:int = 0):void{
      _margin = margin;
      checkPic(pic);
    }
    public function setMax(max:int):void {
      this._max = max;
    }
    private function gc():void {
    }
    public function render():void{
      var w:int = 0;
      var h:int = 0;
      var bits:Array = [];
      for (var i:int = 0; i < this._floor; i++) {
        var bit:Rectangle = new Rectangle();
        bit.width = _pic.width;
        bit.height = _pic.height;
        bit.y = i * (_margin + bit.height);
        h = bit.height + i * (_margin + bit.height);
        w = bit.width>w?bit.width:w;
        bits.unshift(bit);
//        bit.x = int(Math.random() * 2);
      }
      var data:BitmapData;
      if (bits.length > 0) {
        data = new BitmapData(w, h, true, 0x0000000);
        var y:int = 0;
        for each(var bit:Rectangle in bits){
          data.copyPixels(_pic,new Rectangle(0,0,bit.width,bit.height),new Point(bit.x,bit.y),null,null,true);
          y++;
        }
      } else {
        data = new BitmapData(1, 1, true, 0x00000000);
        trace("LRTower floor "+_floor);
      }

      if (this._main.bitmapData != null) {
        this._main.bitmapData.dispose();
        this._main.bitmapData = null;
      }
      this._main.bitmapData = data;
      this._main.y = _h - this._main.height;
      gc();
    }
    public function appendFloor(num:int,pic:DisplayObject = null,margin:int = 0):void{
      if(pic!=null){
        this.setPic(pic,margin);
      }
      this.setFloor(num);
      render();
    }
    public function setFloor(num:int):void {
      _floor = num > _max ? _max : num;
    }

    public function get h():int {
      return _h;
    }

    public function get floor():int {
      return _floor;
    }
    public function clear():void{
      _pic.dispose();
      if(this._main!= null && this._main.bitmapData != null) {
        this._main.bitmapData.dispose();
      }

      while(this.numChildren>0){
        this.removeChildAt(0);
      }
    }

    public function dispose():void {
      clear();
    }

    public function get towerName():String {
      return _towerName;
    }

    public function set towerName(value:String):void {
      _towerName = value;
    }
  }
}
