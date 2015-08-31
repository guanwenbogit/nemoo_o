package com.util.img {
  import flash.display.BitmapData;
  import flash.display.Bitmap;
  import flash.display.DisplayObject;
  /**
   * @author wbguan
   */
  public class ImageBuffer extends Object {
    protected var _map:Object = new Object();
    protected static var _instance:ImageBuffer;
    public function ImageBuffer() {
    }
    public static function get instance():ImageBuffer {
      if(_instance == null){
        _instance = new ImageBuffer();
      }
      return _instance;
    }
    public function addImageByUrl(url:String,image:Bitmap):void {
      _map[url] = image;
    }

    public function getImageByUrl(url:String):BitmapData {
      var result:BitmapData;
      var bit:Bitmap;
      if(_map[url] != null){
        bit = _map[url] as Bitmap;
        result = bit.bitmapData;
      }
      return result;
    }
  }
}
