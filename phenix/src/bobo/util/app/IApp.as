/**
 * Created by wbguan on 2015/5/5.
 */
package bobo.util.app {
  import com.util.net.sdk.IConnection;

  import flash.events.IEventDispatcher;

  public interface IApp extends IEventDispatcher{
    function init(connection:IConnection,...args):void;
    function render(param:String):void
    function get w():int;
    function get h():int;
    function close():void;
    function dispose():void;
    function recover():void;
    function refresh():void;
  }
}
