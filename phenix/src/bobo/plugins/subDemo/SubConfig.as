/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.subDemo {
  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;
  import robotlegs.bender.framework.api.IConfig;
  import robotlegs.bender.framework.api.IInjector;

  public class SubConfig implements IConfig {
    [Inject]
    public var injector:IInjector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var cmdMap:IEventCommandMap;
    [Inject]
    public var signalMap:ISignalCommandMap;
    public function SubConfig() {

    }

    public function configure():void {
      mediatorMap.map(SubTestView).toMediator(SubTestViewMediator);
    }
  }
}
