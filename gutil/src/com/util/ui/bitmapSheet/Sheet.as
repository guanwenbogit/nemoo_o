package com.util.ui.bitmapSheet {

  import flash.display.PixelSnapping;
  import flash.geom.Matrix;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  /**
   * @author wbguan
   */
  public class Sheet extends Object {
    //----------------------------------
    //  bitmapData
    //----------------------------------
    private var _bitmapData:BitmapData;
    public function get bitmapData():BitmapData {
      return _bitmapData;
    }
    private var _bitmap:Bitmap;
    public function Sheet(bitmapdata:BitmapData) {
      this._bitmapData = bitmapdata;

      this._bitmap = new Bitmap();
      this._bitmap.bitmapData = this._bitmapData;
    }
    private var _dataMap:Object = {};
    
    public function get bitmap() : Bitmap {
      return _bitmap;
    }
    
    public function getTileBitMap(frame:Frame):Bitmap {
      var result:Bitmap = new Bitmap();
      result.smoothing = true;
      result.pixelSnapping = PixelSnapping.NEVER;
      var data:BitmapData = getTileBitmapData(frame);
      result.bitmapData = data;
      return result;
    }
    public function getTileBitmapData(frame:Frame):BitmapData {
      var result:BitmapData = this._dataMap[frame.name];
      if(result == null) {
        var tmp:BitmapData = new BitmapData(frame.w, frame.h, true, 0x00ffffff);
        tmp.copyPixels(this._bitmapData, new Rectangle(frame.x, frame.y, frame.w, frame.h), new Point(0, 0));
        if (frame.rotated) {
          result = new BitmapData(frame.h, frame.w, true, 0x00ffffff);
          var m:Matrix = new Matrix();
          m.rotate(-Math.PI / 2);
          m.translate(0, tmp.width);
          result.draw(tmp, m);
        } else {
          result = tmp
        }
        this._dataMap[frame.name] = result;
      }
      return result;
    }
    public function dispose():void{
      for(var key:String in _dataMap){
        var result:BitmapData = _dataMap[key];
        result.dispose();
        _dataMap[key] = null;
      }
      _dataMap = {};
    }
  }
}
