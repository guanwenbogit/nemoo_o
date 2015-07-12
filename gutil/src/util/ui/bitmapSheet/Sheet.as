package util.ui.bitmapSheet {

  import flash.display.PixelSnapping;
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
    
    public function get bitmap() : Bitmap {
      return _bitmap;
    }
    
    public function getTileBitMap(frame:Frame):Bitmap {
      var result:Bitmap = new Bitmap();
      result.smoothing = true;
      result.pixelSnapping = PixelSnapping.NEVER;
      var data:BitmapData = new BitmapData(frame.w, frame.h, true, 0xffffffff);
      data.copyPixels(this._bitmapData, new Rectangle(frame.x, frame.y, frame.w, frame.h), new Point(0, 0));
      result.bitmapData = data;

      return result;
    }
    public function getTileBitmapData(frame:Frame):BitmapData {
      var data:BitmapData = new BitmapData(frame.w, frame.h, true, 0xffffffff);
      data.copyPixels(this._bitmapData, new Rectangle(frame.x, frame.y, frame.w, frame.h), new Point(0, 0));
      return data;
    }
  }
}
