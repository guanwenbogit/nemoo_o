/**
 * Created by wbguan on 2015/4/22.
 */
package com.util.ui.bitmapSheet {
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
    protected var _frames:Vector.<Frame> = new <Frame>[];
    protected var _bitmapData:BitmapData ;
    private var _sheet:Sheet;
    private var _json:SheetJson = new SheetJson();
    private var _img:Bitmap;
    private var _jsonObj:Object;
    private var loader:SheetLoader;

    public function SheetPoolElement() {
      super();
    }
    public function setBitmapData(data:BitmapData, json:Object):void {
      _bitmapData = data;
      _jsonObj = json;
      init();
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
        this._bitmapData = _img.bitmapData;
        this.init();
      }else{
        _success = false;
        loader.dispose();
        loader = null;
      }
      trace("SheetPoolElement loaded  "+ this.imgUrl + " | " + this.jsonUrl + " ; " + (this._bitmapData != null) + " | " + (this._json != null));
      if(callBack != null){
        callBack(this);
      }
    }

    protected function init():void{
      _json.init(_jsonObj);
      this._sheet = new Sheet(this._bitmapData);
      for each(var obj:Object in _json.frames){
        var frame:Frame = new Frame(obj);
        this._frames.push(frame);
      }
    }

    public function getBitmap(name:String):Bitmap{
      var result:Bitmap;
      result = this._sheet.getTileBitMap(getFrame(name));
      return result;
    }
    public function getBitmapData(name):BitmapData{
      var result:BitmapData;
      result = this._sheet.getTileBitmapData(getFrame(name));
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
      if(_bitmapData!=null){
        _bitmapData.dispose();
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

    public function get jsonStr():String{
      var result:String = "";
      if(_jsonObj != null){
        result = JSON.stringify(_jsonObj);
      }
      return result;
    }

    public function get success():Boolean {
      return _success;
    }

    public function get frames():Vector.<Frame> {
      return _frames;
    }
  }
}
