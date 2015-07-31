/**
 * Created by wbguan on 2015/4/22.
 */
package util.ui.bitmapSheet {

  import flash.display.Loader;

  public class SheetPool extends Object {
    private var _map:Object = {};
    private var _keys:Array = [];
    private var _clazz:Class;
    public function SheetPool(clazz:Class = null) {
      super();
      if(clazz == null) {
        _clazz = SheetPoolElement;
      }else{
        _clazz = clazz;
      }
    }
    /*
    * callBack(param:SheetPoolElement);
    * */
    public function getSheetMap(imgUrl:String,jsonUrl:String,callBack:Function):void{
      load(imgUrl, jsonUrl, callBack);
    }

    private function load(imgUrl:String,jsonUrl:String,callBack:Function):void{
      if(_keys.indexOf(imgUrl)<0){
        _keys.push(imgUrl);
      }
      var ele:SheetPoolElement = _map[imgUrl];
      if(ele == null){
        ele = new _clazz();
        _map[imgUrl] = ele;
        ele.imgUrl = imgUrl;
        ele.jsonUrl = jsonUrl;
        ele.callBack = callBack;
        ele.load();
      }else {
        if (ele.success) {
          if (ele.callBack != null) {
            ele.callBack(ele);
          }
        } else if (!ele.retried) {
          ele.load();
          ele.retried = true;
        }
      }
    }

    public function dispose():void{
      var key:String = "";
      while(this._keys.length > 0){
        key = this._keys.pop();
        var ele:SheetPoolElement = this._map[key] as SheetPoolElement;
        if(ele != null){
          ele.dispose();
        }
        this._map[key] = null;
        delete this._map[key];
      }
    }

  }
}
