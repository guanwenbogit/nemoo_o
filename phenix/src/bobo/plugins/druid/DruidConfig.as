/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.druid {

  import bobo.plugins.druid.txt.ChatPanel;
  import bobo.plugins.druid.txt.mediator.ChatPanelMediator;

  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.framework.api.IConfig;
  import robotlegs.bender.framework.api.IInjector;

  public class DruidConfig implements IConfig{
    [Inject]
    public var injector:IInjector;
    [Inject]
    public var mediatorMap:IMediatorMap;
    [Inject]
    public var cmdMap:IEventCommandMap;

    public function DruidConfig() {
    }

    public function configure():void {
      mediatorMap.map(Druid).toMediator(DruidViewMediator);
      mediatorMap.map(ChatPanel).toMediator(ChatPanelMediator);
    }
  }
}
