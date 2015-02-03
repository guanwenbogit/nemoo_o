/**
 * Created by wbguan on 2015/1/29.
 */
package mk {
  import mk.init.InitScene;
  import mk.init.InitView;
  import mk.welcome.WelcomeScene;
  import mk.welcome.WelcomeView;

  import system.api.MouldMap;

  import system.api.SceneMap;
  import system.api.ISceneConfig;
  import system.mould.DataMould;

  public class MKAppConfig implements ISceneConfig {
    public function MKAppConfig() {
    }

    public function config():void {
      SceneMap.Instance.addScene(InitScene,InitView);
      SceneMap.Instance.addScene(WelcomeScene,WelcomeView);

      MouldMap.instance.add("initView",InitView);
      MouldMap.instance.add("net",NetMould);
      MouldMap.instance.add("welcome",WelcomeView);
      MouldMap.instance.add("data",DataSource);
    }
  }
}
