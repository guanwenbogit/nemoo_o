/**
 * Created by wbguan on 2015/4/30.
 */
package util.page {
  public class LRPage extends Object {
    private var _current:int = 0;
    private var _perCount:int;
    private var _startIndex:int = 0;
    private var _total:int;
    public function LRPage() {
      super();
    }
    public function next():void{
      if(nextEnable) {
        _current++;
        _startIndex = _current * perCount;
      }
    }
    public function prev():void{
      if(prevEnable) {
        _current--;
        _startIndex = _current * perCount;
      }
    }
    public function get nextEnable():Boolean{
      var result:Boolean;
      result = (_current+1)*_perCount <_total;
      return result;
    }
    public function get prevEnable():Boolean{
      var result:Boolean;
      result = _current>0;
      return result;
    }
    public function get perCount():int {
      return _perCount;
    }

    public function set perCount(value:int):void {
      _perCount = value;
    }

    public function get startIndex():int {
      return _startIndex;
    }
    public function get endIndex():int{
      var result:int = 0;
      result = _startIndex + _perCount;
      result = result >= _total?(_total):result
      return result;
    }

    public function get total():int {
      return _total;
    }

    public function set total(value:int):void {
      _total = value;
    }
    public function gotoPage(value:int):void{
      _current = value;
      _startIndex = _current * perCount;
    }
/*
* begin with 0;
* */
    public function get current():int {
      _current = _current<0?0:_current;
      var max:int = int(_total/_perCount);
      _current = _current>max?max:_current;
      return _current;
    }
  }
}
