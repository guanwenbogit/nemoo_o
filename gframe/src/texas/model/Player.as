/**
 * Created by wbguan on 15/7/24.
 */
package texas.model {
  public class Player {
    private var _userId:String = "";
    private var _nick:String = "";
    private var _pokers:Vector.<Poker> = new <Poker>[];
    private var _lv:int = 0;
    private var _chip:int = 0;

    public function Player() {
    }

    public function init(data:Object):void{

    }

    public function update(data:Object):void{

    }

    public function get userId():String {
      return _userId;
    }

    public function get nick():String {
      return _nick;
    }

    public function get pokers():Vector.<Poker> {
      return _pokers;
    }

    public function get lv():int {
      return _lv;
    }

    public function get chip():int {
      return _chip;
    }

    public function set lv(value:int):void {
      _lv = value;
    }

    public function set chip(value:int):void {
      _chip = value;
    }
  }
}
