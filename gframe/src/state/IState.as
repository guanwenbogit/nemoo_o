/**
 * Created by wbguan on 15/7/11.
 */
package state {
public interface IState {
  function get next():String;
  function set name(value:String);
  function begin(stateComplete:Function):void;
  function end():void;
  function attachExe(exe:IExe):void
  function attachExes(...args):void
  function get name():String;
  
  function breakOff():void;
}
}
