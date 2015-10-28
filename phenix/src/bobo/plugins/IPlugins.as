/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins {
  import flash.events.IEventDispatcher;

  public interface IPlugins extends IEventDispatcher{
    function init(...args):void;
  }
}
