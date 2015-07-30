/**
 * Created by wbguan on 15/7/24.
 */
package texas.model {
  public class BoardModel {
    private var _sum:int = 0;
    private var _preSum:int = 0;

    public function BoardModel() {
    }

    public function get sum():int {
      return _sum;
    }

    public function set sum(value:int):void {
      _sum = value;
    }

    public function append(param:int):void{
      _preSum = _sum;
      _sum += param;
    }

    public function reset():void{
      _preSum = 0;
      _sum = 0;
    }

    public function get preSum():int {
      return _preSum;
    }

    public function set preSum(value:int):void {
      _preSum = value;
    }
  }
}
