package util {
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.external.ExternalInterface;
  import flash.filters.BitmapFilterQuality;
  import flash.filters.GlowFilter;

  /**
   *
   * @author yangfan2012@corp.netease.com
   *
   */
  public class Debug extends Sprite {
    public function Debug() {
      super();
    }

    /**
     * 显示对象外发光
     * @param _displayObject
     * @param _add: 添加或去除外发光。
     * @param _color: 0x009922绿，0xff0000红, 0x0099ff蓝，0xffff00黄。
     *
     */
    public static function glow(_displayObject:DisplayObject, _add:Boolean = true, _color:Number = 0x009922):void {
      if (_add) {
        var glow:GlowFilter = new GlowFilter();
        glow.color = _color;
        glow.alpha = 1;
        glow.blurX = 25;
        glow.blurY = 25;
        glow.quality = BitmapFilterQuality.MEDIUM;

        _displayObject.filters = [glow];
      } else
        _displayObject.filters = [];
    }

    public static function alert(_obj:Object):void {
      try {
        ExternalInterface.call("alert('" + _obj.toString() + "')");
      }
      catch (error:Error) {
        trace("Debug.alert", error);
      }
    }

    public static function console(_obj:Object):void {
      try {
        ExternalInterface.call("console.log('[" + logTime() + "] " + _obj.toString() + "')");
        ExternalInterface.call("console.log('----------')");
      }
      catch (error:Error) {

        trace("Debug.console", error);
      }
//      trace("DEBUG " +_obj.toString());
    }

    private static function logTime():String {
      var d:Date = new Date();

      var _y:String = d.fullYear.toString();

      var _m:String = (d.month + 1).toString();
      if (int(_m) < 10) _m = "0" + _m;

      var _date:String = d.date.toString();
      if (int(_date) < 10) _date = "0" + _date;

      var _h:String = d.hours.toString();
      if (int(_h) < 10) _h = "0" + _h;

      var _minute:String = d.minutes.toString();
      if (int(_minute) < 10) _minute = "0" + _minute;

      var _s:String = d.seconds.toString();
      if (int(_s) < 10) _s = "0" + _s;

      var _ms:String = d.milliseconds.toString();
      if (_ms.length == 1)
        _ms = _ms + "  ";
      else if (_ms.length == 2)
        _ms = _ms + " ";

      return _y + "-" + _m + "-" + _date + " " + _h + ":" + _minute + ":" + _s + "." + _ms;
    }
  }
}