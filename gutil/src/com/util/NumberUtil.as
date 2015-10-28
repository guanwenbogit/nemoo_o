/**
 * Created by wbguan on 2015/6/25.
 */
package com.util {
  public class NumberUtil extends Object {
    public function NumberUtil() {
      super();
    }

    public static function getNumArr(num:int, ary:Array):Array {
      var result:Array = [];
      var tmp:int = num;
      var b:int = 0;
      var len:int = ary.length;
      for (var i:int = 0; i < len; i++) {
        b = int(tmp / ary[i]);
        result.push(b);
        tmp = tmp % ary[i];
      }
      return result;
    }

    public static function getNum10Arr(num:int):Array {
      var result:Array = [];
      var tmp:int = num;
      var b:int = 0;
      while (tmp > 0) {
        b = tmp % 10;
        result.unshift(b);
        tmp = int(tmp / 10);
      }

      return result;
    }

    public static function largeNumToStr(num:Number):String {
      var result:String = num.toString();
      var tmp:Number = num;
      var unit:Array = ["万","亿"];
      var i:int = 0;
      while(tmp>=10000&&i<unit.length){
        tmp = int(tmp/10000);
        result = tmp+unit[i];
        i++;
      }
      return result;
    }

  }
}
