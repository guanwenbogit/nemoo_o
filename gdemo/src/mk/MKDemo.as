/**
 * Created by wbguan on 2015/1/29.
 */
package mk {
  import flash.display.Sprite;
  import flash.events.Event;

  import mk.init.InitView;
  import mk.welcome.WelcomeView;

  import system.Sys;

  import system.api.IData;
  import system.api.ILayout;

  import system.api.ISceneProvider;
  import system.api.ISysMould;
  import system.api.IView;
  import system.api.MouldMap;

  import system.api.hub.HubPool;
  import system.layout.sub.OLayout;

  public class MKDemo extends Sprite {

    public function MKDemo() {
      super();

      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
    }

    private function onAdded(event:Event):void {
      var sys:Sys = new Sys(MKAppConfig,OLayout,this.root);
      sys.run("initView");
    }
  }
}
