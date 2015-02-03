/**
 * Created by wbguan on 2015/1/29.
 */
package system.api {
  public interface IView {
    function bindScene(scene:IScene):void
    function get scene():IScene;
    function get name():String;
    function get layout():String
  }
}
