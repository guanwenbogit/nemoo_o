/**
 * Created by wbguan on 2015/3/9.
 */
package com.util.ui.bitmapSheet {
  public class SheetJson {
    private var _source:Object;
    public function SheetJson() {
    }
    public function init(source:Object):void{
      _source = JSON.parse(String(source));
    }
    public function get frames():Array{
      return _source["frames"] as Array;
    }
  }
}
