/**
 * Created by wbguan on 15/7/24.
 */
package texas.model {
  public class Poker {
    private var _point:int = 0;
    private var _suit:String = "";
    public function Poker() {
    }

    public function get point():int {
      return _point;
    }

    public function get suit():String {
      return _suit;
    }

    public function set point(value:int):void {
      _point = value;
    }

    public function set suit(value:String):void {
      _suit = value;
    }
  }
}
