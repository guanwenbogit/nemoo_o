/**
 * Created by wbguan on 2015/2/2.
 */
package system {
  import system.api.IData;
  import system.api.ILayout;
  import system.api.IModel;

  import system.api.IScene;
  import system.api.ISceneConfig;
  import system.api.ISceneProvider;
  import system.api.ISysMould;
  import system.api.IView;
  import system.api.ModelMap;

  import system.api.MouldMap;
  import system.api.hub.HubPool;

  import system.mould.Mould;
  import system.scene.StageSceneProvider;

  public class Sys extends Mould{
    private var _sceneProvider:ISceneProvider;
    private var _layout:ILayout;
    private var _config:ISceneConfig;

    public function Sys(config:Class,layout:Class,root:Object,hubPool:HubPool=null) {
      super(hubPool);
      _config = new config();
      _config.config();
      _layout = new layout(root);
      _sceneProvider = new StageSceneProvider();
    }

    override public function get outside():HubPool {
      return super._inside;
    }

    override protected function init():void {
      super.init();
    }

    public function run(clazz:String):void{
      onInitMould(clazz);
    }
    private function onInitMould(str:String):void {
      var action:String = str;
      var clazz:Class = MouldMap.instance.getClass(action);
      if(clazz != null){
        var mould:ISysMould = new clazz(this._inside);
        if(mould is IView){
          var scene:IScene = _sceneProvider.createScene(clazz);
          var view:IView = mould as IView;
          _layout.addScene(view.layout,scene);
          view.bindScene(scene);
        }
        if(mould is IData){
          var model:IModel = ModelMap.instance.getModel(action);
          var data:IData = mould as IData;
          data.bindModel(model);
        }
      }
    }

  }
}
