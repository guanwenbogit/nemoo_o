/**
 * Created by wbguan on 15/7/24.
 */
package texas.model {
  public class Table {
    private var _main:BoardModel;
    private var _sides:Vector.<BoardModel> = new <BoardModel>[];
    private var _players:Vector.<BoardModel> = new <BoardModel>[];
    private var _count:int = 0;

    public function Table() {
    }
    public function init(count:int):void{
      _count = count;
      _main = new BoardModel();
      initSides();
      initPlayer();
    }
    private function initSides():void{
      for(var i:int = 0;i<_count;i++){
        var board:BoardModel = new BoardModel();
        this._sides.push(board);
      }
    }
    private function initPlayer():void{
      for(var i:int = 0;i<_count;i++){
        var board:BoardModel = new BoardModel();
        this._players.push(board);
      }
    }
    public function getPlayer(index:int):BoardModel{
      var result:BoardModel;
      if(index<_players.length&&index>=0){
        result = _players[index];
      }
      return result;
    }
    public function getSide(index:int):BoardModel{
      var result:BoardModel;
      if(index<_sides.length&&index>=0){
        result = _sides[index];
      }
      return result;
    }

    public function get main():BoardModel {
      return _main;
    }
  }
}
