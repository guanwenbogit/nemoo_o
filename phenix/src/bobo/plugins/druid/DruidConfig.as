/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.druid {

  import bobo.constants.MessageType;
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.plugins.druid.txt.ChatElementBuilder;
  import bobo.plugins.druid.txt.cmd.ChatCmd;
  import bobo.plugins.druid.cmd.DruidCmd;
  import bobo.plugins.druid.txt.ChatModel;
  import bobo.plugins.druid.txt.ChatPanel;
  import bobo.plugins.druid.txt.mediator.ChatPanelMediator;
  import bobo.util.net.event.MessageSimpleEvent;

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
      //===============interface===============
      cmdMap.map(SimpleType.DRUID_PUBLISH_MESSAGE,SimpleEvent).toCommand(DruidCmd);
      cmdMap.map(SimpleType.DRUID_SWITCH_TAB,SimpleEvent).toCommand(DruidCmd);

      //===============inner reg===============
      injector.map(ChatModel).asSingleton();
      injector.map(ChatElementBuilder).asSingleton();
      mediatorMap.map(Druid).toMediator(DruidViewMediator);
      mediatorMap.map(ChatPanel).toMediator(ChatPanelMediator);
      cmdMap.map(MessageType.RESP_GROUP_CHAT_MSG,MessageSimpleEvent).toCommand(ChatCmd);
    }
  }
}
