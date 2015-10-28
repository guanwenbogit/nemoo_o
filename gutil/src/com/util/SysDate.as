/**
 * Created by wbguan on 2015/6/29.
 */
package com.util {
  import flash.utils.getTimer;

  public class SysDate {
    protected static var _date:Number = 0;
    private static var _last:Number=0;
    public static function init(date:Number = 0):void{
      _date = date;
      _last = getTimer();
    }
    public static function current():Number{
      return getTimer()-_last+_date;
    }
    public static function currentDate():Date{
      return new Date(current);
    }

    public function SysDate() {
    }
  }
}
