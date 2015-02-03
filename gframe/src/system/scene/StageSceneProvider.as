/**
 * Created by wbguan on 2015/1/29.
 */
package system.scene {
  import flash.display.Stage;

  import system.api.IScene;
  import system.api.ISceneConfig;
  import system.api.ISceneProvider;
  import system.api.SceneMap;
  import system.util.container.IContainer;

  public class  StageSceneProvider extends Object implements ISceneProvider {
    protected var _map:Object = {};
    public function StageSceneProvider() {
      super();
    }

    public function remove():void {
    }

    public function createScene(param:Object):IScene {
      var result:IScene;
      result = _map[param];
      if(result == null){
        var clazz:Class = SceneMap.Instance.getScene(param);
        result = new clazz();
        _map[param] = result;
      }
      return result;
    }

  }
}
