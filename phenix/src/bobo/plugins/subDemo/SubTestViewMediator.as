/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.subDemo {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;

  import flash.events.IEventDispatcher;

  import robotlegs.bender.bundles.mvcs.Mediator;

  public class SubTestViewMediator extends Mediator {

    [Inject]
    public var view:SubTestView;
    [Inject]
    public var dispatcher:IEventDispatcher;
    override public function initialize():void {
      super.initialize();
      trace("SubTestViewMediator med init");
//      dispatcher.dispatchEvent(new SimpleEvent(SimpleType.DRUID_INIT,null));
    }

    override public function destroy():void {
      super.destroy();
      trace("SubTestViewMediator med destroy");
    }

    public function SubTestViewMediator() {
      super();
    }
  }
}
