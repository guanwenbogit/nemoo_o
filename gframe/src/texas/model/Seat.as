/**
 * Created by wbguan on 15/7/24.
 */
package texas.model {

  public class Seat {
    private var _index:int = -1;
    private var _player:Player = null;
    private var _idle:Boolean = true;

    public function Seat() {
    }

    public function setPlayer(player:Player):void{
      if(_idle) {
        _player = player;
        _idle = false;
      }
    }

    public function popPlayer():Player{
      var result:Player;
      result = _player;
      _player = null;
      _idle = true;
      return result;
    }

    public function get Idle():Boolean{
      return _idle;
    }

    public function get index():int {
      return _index;
    }

    public function set index(value:int):void {
      _index = value;
    }
  }
}
