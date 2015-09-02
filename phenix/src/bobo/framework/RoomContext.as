/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.framework {
  import bobo.config.AppConfig;
  import bobo.config.ModulesConfig;
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;

  import com.plugin.log.LogUtil;


  import flash.display.DisplayObjectContainer;
  import flash.events.IEventDispatcher;

  import robotlegs.bender.bundles.mvcs.MVCSBundle;
  import robotlegs.bender.extensions.contextView.ContextView;
  import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;

  import robotlegs.bender.framework.impl.Context;

  public class RoomContext extends Context {
    private var _root:DisplayObjectContainer;
    public function RoomContext(param:DisplayObjectContainer) {
      super();
      _root = param;
      setup();
    }

    private function setup():void{
      this.install(MVCSBundle, SignalCommandMapExtension)
              .configure(AppConfig,ModulesConfig)
              .configure(new ContextView(_root))
              .initialize(initCallback);
    }

    private function initCallback():void{
      LogUtil.info("room context callback ","RoomContext");
      this.injector.getInstance(IEventDispatcher).dispatchEvent(new SimpleEvent(SimpleType.MAIN_SHELL_INIT,null));
    }

  }
}
