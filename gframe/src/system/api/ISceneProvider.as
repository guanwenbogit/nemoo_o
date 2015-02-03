/**
 * Created by wbguan on 2015/1/29.
 */
package system.api {
  import flash.display.Stage;

  public interface ISceneProvider {
    function createScene(param:Object):IScene;
  }
}
