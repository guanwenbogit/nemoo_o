/**
 * Created by wbguan on 15/7/11.
 */
package machine {
  public class Machine {
    protected static const IDLE:String = "IDLE";
    private var _map:Object = {};
    private var _states:Vector.<IState> = new <IState>[];
    private var _current:IState;
    private var _buffer:Array = [];

    public function attachState(state:IState):void {
      if (this._map[state.name] == null) {
        this._map[state.name] = state;
        this._states.push(state);
      } else {
        throw new Error("existed state name : " + state.name);
      }
    }

    public function attachStates(...args):void {
      for each(var state:IState in args) {
        attachState(state);
      }
    }

    public function run(name:String = ""):void {
      if(isIdle()) {
        if (name == null || name.length == 0) {
          if (this._states.length > 0) {
            _current = this._states[0];
          }
        } else {
          _current = _map[name];
        }
        stateBegin();
      }else{
        this._buffer.push(name);
      }
    }

    private function stateComplete(next:String):void {
      if (_current != null) {
        _current.end();
        _current = null;
      }
      _current = this._map[next];
      action();
    }

    private function action():void{
      if(!isIdle()) {
        _current.begin(stateComplete);
      }else{
        var name:String = this._buffer.shift();
        _current = this._map[name];
        action();
      }
    }

    private function stateBegin():void {
      if (isIdle()) {
        _current.begin(stateComplete);
      } else {
        trace("the sys is buys now ! " + this._current.name);
      }
    }

    public function isIdle():Boolean {
      var result:Boolean = (state == IDLE);
      return result;
    }

    public function get state():String {
      var result:String = IDLE;
      if (_current != null) {
        result = _current.name;
      }
      return result;
    }

    public function force(name:String):void {
      if (!isIdle()) {
        breakOff();
      }
      run(name);
    }

    public function breakOff():void {
      if (_current != null) {
        _current.breakOff();
        _current.end();
        _current = null;
      }
    }

    public function Machine() {
    }

  }
}
