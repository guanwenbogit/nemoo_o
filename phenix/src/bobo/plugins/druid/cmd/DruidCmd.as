/**
 * Created by wbguan on 2015/10/15.
 */
package bobo.plugins.druid.cmd {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.plugins.druid.txt.ChatModel;

  import robotlegs.bender.bundles.mvcs.Command;

  public class DruidCmd extends Command {
    [Inject]
    public var event:SimpleEvent;
    [Inject]
    public var chatModel:ChatModel;
    override public function execute():void {
      super.execute();
      switch (event.type){
        case SimpleType.DRUID_PUBLISH_MESSAGE:
          chatModel.publishSimpleContent(String(event.data),null,"","",null,null);
          break;
      }
    }

    public function DruidCmd() {
      super();
    }
  }
}
