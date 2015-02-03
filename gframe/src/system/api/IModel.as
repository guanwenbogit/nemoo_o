/**
 * Created by wbguan on 2015/1/29.
 */
package system.api {
  import system.api.hub.Hub;

  public interface IModel {
    function get name():String;
    function set name(value:String):void;
    function update(obj:Object):void;
  }
}
