/**
 * Created by wbguan on 2015/1/23.
 */
package system.api.hub {
  import flash.events.EventDispatcher;

  public class Hub {
    private var _name:String;
    private var _funcs:Vector.<Function> = new Vector.<Function>();
    public function get name():String {
      return _name;
    }

    public function set name(value:String):void {
      _name = value;
    }
    public function publish(...args):void{
      for each(var func:Function in this._funcs){
        func.apply(null,args);
      }
    }
    public function listen(func:Function):void{
      this._funcs.push(func);
    }
    public function remove(func:Function):void{
      var i:int = this._funcs.indexOf(func);
      if(i>=0){
        this._funcs = this._funcs.splice(i,1);
      }
    }
    public function Hub() {

    }

    public function dispose():void {
      while(this._funcs.length > 0){
        this._funcs.pop();
      }
    }
  }
}
