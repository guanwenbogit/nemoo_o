/**
 * Created by wbguan on 2015/4/22.
 */
package util.ui.bitmapSheet {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.PixelSnapping;


  public class SheetPoolElement extends Object {
    public var imgUrl:String = "";
    public var jsonUrl:String = "";
    public var callBack:Function = null;
    public var retried:Boolean = false;

    private var _success:Boolean = false;
    private var _frames:Vector.<Frame> = new <Frame>[];
    private var _bitmapData:BitmapData ;
    private var _sheet:Sheet;
    private var _json:SheetJson = new SheetJson();
    private var _img:Bitmap;
    private var _jsonObj:Object;
    private var loader:SheetLoader;

    private var _buffer:Object = new Object();
    public function SheetPoolElement() {
      super();
    }

    public function load():void {
      if(loader == null){
        loader = new SheetLoader();
        loader.load(imgUrl,jsonUrl,loaded)
      }
    }

    private function loaded(param1:DisplayObject,param2:Object):void {
      _img = param1 as Bitmap;
      _img.smoothing = true;
      _img.pixelSnapping = PixelSnapping.ALWAYS;
      _jsonObj = param2;
      if(_img != null && _jsonObj != null) {
        _success = true;
        this.init();
      }else{
        _success = false;
        loader.dispose();
        loader = null;
      }
      if(callBack != null){
        callBack(this);
      }
    }

    private function init():void{
      _json.init(_jsonObj)
      this._bitmapData = _img.bitmapData;
      this._sheet = new Sheet(this._bitmapData);
      for each(var obj:Object in _json.frames){
        var frame:Frame = new Frame(obj);
        this._frames.push(frame);
      }
    }

/*    private function createBufferBitmap(name:String):Bitmap{
      var result:Bitmap = new Bitmap();
      var arr:Array = this._buffer[name] as Array;
      if(arr == null){
        arr = [];
        this._buffer[name] = arr;
      }
      arr.push(result);
      return result;
    }*/
    /*
     * one can get a bitmap without bitmapData before init func was called
     * then after called init func,that bitmap would be filled with bitmapData ,if the name was a frame name.
     * */
    public function getBitmap(name:String):Bitmap{
      var result:Bitmap;
      result = this._sheet.getTileBitMap(getFrame(name));
      return result;
    }
    private function getFrame(name:String):Frame{
      var result:Frame;
      for each(var frame:Frame in this._frames){
        if(frame.name == name){
          result = frame;
          break;
        }
      }
      return result;
    }

    public function getBitmapDataArr():Array{
      var result:Array = [];
      for each(var frame:Frame in this._frames){
        var bitMapData:BitmapData = this._sheet.getTileBitmapData(frame);
        result.push(bitMapData);
      }
      return result;
    }

    public function failed():void {

    }
    public function dispose():void{
      if(_img != null){
        _img.bitmapData.dispose();
      }
      if(this.loader != null){
        this.loader.dispose();
      }
      this.loader = null;
      _bitmapData = null;
      _img = null;
      _jsonObj = null;
      callBack = null;
      imgUrl = "";
      jsonUrl = "";
    }

    public function get success():Boolean {
      return _success;
    }
  }
}