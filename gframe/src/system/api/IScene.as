/**
 * Created by wbguan on 2015/1/29.
 */
package system.api {
  import system.util.container.IContainer;

  public interface IScene{
    function update(obj:Object):void;
    function remove():void;
    function get container():IContainer;
  }
}
