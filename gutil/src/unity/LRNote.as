/**
 * Created by wbguan on 2015/1/23.
 */
package unity {
  public class LRNote {
    private var _data:Object;
    public function get data():Object {
      return _data;
    }

    public function set data(value:Object):void {
      _data = value;
    }
    private var _next:LRNote;
    public function get next():LRNote {
      return _next;
    }

    public function set next(value:LRNote):void {
      _next = value;
    }
    public function clear():void{
      this._data = null;
      if(this._next != null){
        this._next.clear();
      }
    }
    public function LRNote() {
    }
  }
}
