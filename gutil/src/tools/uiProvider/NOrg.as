/**
 * Created by wbguan on 2015/8/31.
 */
package tools.uiProvider {
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  import com.util.ui.bitmapSheet.Frame;

  import com.util.ui.bitmapSheet.SheetPoolElement;

  import com.util.ui.unity.NButton;

  public class NOrg extends Object {
    private var _name:String;
    private var _source:BitmapData;
    private var _sheet:SheetPoolElement;
    private var _btns:Object = {};
    private var _bgs:Object = {};

    public function NOrg(param:SheetPoolElement) {
      super();
      _sheet = param;
      _name = _sheet.imgUrl;
      init();
    }

    private function init():void {
      for each(var frame:Frame in _sheet.frames) {
        parse(frame);
      }
    }

    private function parse(frame:Frame):void {
      var str:String = frame.name;
      str = str.slice(0,str.indexOf("."));
      var strs:Array = str.split("_");
      var type:String = strs[0];
      var name:String = strs[1];
      var obj:Object;
      switch (type) {
        case "btn":
          obj = _btns;
          var arr:Array = obj[name] as Array;
          if (arr == null) {
            arr = new Array();
            obj[name] = arr;
          }
          arr.push(frame.name);
          break;
        case "bg":
          obj = _bgs;
          obj[name]= frame.name;
          break;
      }
    }

    public function getBtn(name:String,label:String = ""):NButton {
      var result:NButton;
      var btnNames:Array = this._btns[name];
      var up:BitmapData;
      var over:BitmapData;
      var down:BitmapData;
      var dis:BitmapData;
      for each(var str:String in btnNames){
        if(str.indexOf("up")>=0){
          up = _sheet.getBitmapData(str);
        }else if(str.indexOf("over")>=0){
          over = _sheet.getBitmapData(str);
        }else if(str.indexOf("down")>=0){
          down = _sheet.getBitmapData(str);
        }else if(str.indexOf("dis")>=0){
          dis = _sheet.getBitmapData(str);
        }
      }
      result = new NButton(up,label,over,down,dis);
      return result;
    }

    public function getBg(name:String):Bitmap{
      var result:Bitmap;
      var name:String = _bgs[name];
      if(name != null && name.length>0){
        result = _sheet.getBitmap(name);
      }
      return result;
    }

  }
}
