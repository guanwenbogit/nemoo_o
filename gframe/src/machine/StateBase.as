/**
 * Created by wbguan on 15/7/12.
 */
package machine {
  public class StateBase implements IState{
    protected var _name:String = "";
    protected var _next:String = "";
    protected var _onComplete:Function;
    protected var _exes:Vector.<IExe> = new <IExe>[];
    protected var _count:int = 0;

    public function StateBase() {
      trace("Please derived son class");
    }

    public function get next():String {
      return this._next;
    }

    public function set name(value:String) {
      this._name = value;
    }

    public function begin(stateComplete:Function):void {
      this._onComplete = stateComplete;
      _count = _exes.length;
      for each(var exe:IExe in this._exes){
        exe.execute();
      }
    }

    public function end():void {
      for each(var exe:IExe in this._exes){
        exe.dispose();
      }
    }

    public function attachExe(exe:IExe):void {
      if(_exes.indexOf(exe)<0) {
        _exes.push(exe);
        exe.addEventListener(ExeEvent.COMPLETE,onExeComplete);
      }
    }

    private function onExeComplete(event:ExeEvent):void {
      _count--;
      check();
    }

    private function check():void {
      if(_count >= 0){
        this._onComplete(_next);
      }
    }
    public function attachExes(...args):void{
      for each(var exe:IExe in args){
        this.attachExe(exe);
      }
    }
    public function get name():String {
      return _name;
    }

    public function breakOff():void {
    }

  }
}
