/**
 * Created by wbguan on 2015/1/30.
 */
package system.api {
  public interface ILayout {
    function addScene(layout:String,scene:IScene):void
    function removeScene(scene:IScene):void
    function layout():void;
  }
}
