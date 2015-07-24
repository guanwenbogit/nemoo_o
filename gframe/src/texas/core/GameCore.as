/**
 * Created by wbguan on 15/7/24.
 */
package texas.core {

  public class GameCore {

    private var _id:int = 0;
    private var _currBet:int = 0;
    private var _miniBet:int = 0;
    private var _current:int = 0;

    public function GameCore() {
    }

    public function get id():int {
      return _id;
    }

    public function get currBet():int {
      return _currBet;
    }

    public function get miniBet():int {
      return _miniBet;
    }

    public function get current():int {
      return _current;
    }

    public function set id(value:int):void {
      _id = value;
    }

    public function set currBet(value:int):void {
      _currBet = value;
    }

    public function set miniBet(value:int):void {
      _miniBet = value;
    }

    public function set current(value:int):void {
      _current = value;
    }

    public function reset():void{
      _currBet = 0;
      _current = -1;
      _id = 0;
      _miniBet = 0;
    }
  }
}
