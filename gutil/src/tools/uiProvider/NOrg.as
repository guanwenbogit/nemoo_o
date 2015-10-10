/**
 * Created by wbguan on 2015/8/31.
 */
package tools.uiProvider {
  import com.plugin.log.LogUtil;
  import com.util.ui.unity.LR9Bitmap;
  import com.util.ui.unity.ScaleBitmap;

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
    public function get success():Boolean{
      return _sheet != null&&_sheet.success;
    }
    private function init():void {
      for each(var frame:Frame in _sheet.frames) {
        parse(frame);
      }
    }

    private function parse(frame:Frame):void {
      var str:String = frame.name;
      str = str.slice(0, str.indexOf("."));
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
          obj[name] = frame.name;
          break;
      }
    }

    public function getBtn(name:String, label:String = ""):NButton {
      var result:NButton;
      var btnNames:Array = this._btns[name];
      var up:BitmapData;
      var over:BitmapData;
      var down:BitmapData;
      var dis:BitmapData;
      for each(var str:String in btnNames) {
        if (str.indexOf("up") >= 0) {
          up = _sheet.getBitmapData(str);
        } else if (str.indexOf("over") >= 0) {
          over = _sheet.getBitmapData(str);
        } else if (str.indexOf("down") >= 0) {
          down = _sheet.getBitmapData(str);
        } else if (str.indexOf("dis") >= 0) {
          dis = _sheet.getBitmapData(str);
        }
      }

      result = new NButton(up, label, over, down, dis);
      return result;
    }

    public function getBg(name:String):Bitmap {
      var result:Bitmap;
      var frame:String = _bgs[name];
      result = _sheet.getBitmap(frame);
      return result;
    }

    public function getScaleBg(name:String):LR9Bitmap {
      var result:LR9Bitmap;
      var name:String = _bgs[name];
      if (name != null && name.length > 0) {
        var str:String = name.slice(0, name.indexOf("."));
        var arr:Array = str.split("_");
        var rectStr:String = "";
        var rectArr:Array;
        if (arr.length >= 3) {
          rectStr = arr[2];
          rectArr = rectStr.split("x");
        }
        var ltrb:Array = [0, 0, 0, 0];
        var n:int = 0;
        for each(var i:int in rectArr) {
          ltrb[n] = i;
          n++;
        }

        var data:Bitmap = _sheet.getBitmap(name);
        result = new LR9Bitmap(data, ltrb[0], ltrb[1], ltrb[2], ltrb[3]);
      }
      if(result == null){
        throw new Error("NOrg can not find img. url:"+_name+"; name: "+name+"\n "+_sheet.jsonStr);
      }
      return result;
    }

  }
}
