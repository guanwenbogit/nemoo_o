/**
 * Created by wbguan on 2015/1/23.
 */
package system.api {
  import system.api.hub.HubPool;
  public interface ISysMould {
    function get name():String;
    function dispose():void;
    function callBack(...args);
    function get outside():HubPool;
  }
}
