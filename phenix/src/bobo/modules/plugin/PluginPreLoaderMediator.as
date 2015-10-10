/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.modules.plugin {
  import flash.display.DisplayObject;
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
      view.addEventListener(Event.COMPLETE,onComplete);
    }
    private function onComplete(event:Event):void {
      view.init();
      view.plugin.init(context);
      view.parent.addChild(view.plugin as DisplayObject);
      view.parent.removeChild(view);
    }

    override public function destroy():void {
      super.destroy();
      view.removeEventListener(Event.COMPLETE,onComplete);
    }

    public function PluginPreLoaderMediator() {
      super();
    }
  }
}
