/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.modules.plugin {
  import flash.events.Event;

  import robotlegs.bender.bundles.mvcs.Mediator;
  import robotlegs.bender.framework.api.IContext;

  public class PluginPreLoaderMediator extends Mediator {
    [Inject]
    public var view:PluginPreLoader;
    [Inject]
    public var context:IContext;

    override public function initialize():void {
      super.initialize();
      trace("PluginPreLoaderMediator initialize");
      view.addEventListener(Event.COMPLETE, onComplete);
    }

    private function onComplete(event:Event):void {
      view.removeEventListener(Event.COMPLETE, onComplete);
      if(view.plugin){
        view.plugin.init(context);
      }
    }

    override public function destroy():void {
      view.addEventListener(Event.COMPLETE, onComplete);
      super.destroy();
    }

    public function PluginPreLoaderMediator() {
      super();
    }
  }
}
