/**
 * Created by wbguan on 15/7/11.
 */
package sys.state {
import flash.events.IEventDispatcher;

public interface IExe extends IEventDispatcher{
  function execute():void;
  function setArgs(...args):void;
  
  function dispose():void;
}
}
