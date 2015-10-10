/**
 * Created by wbguan on 2015/8/25.
 */
package bobo.config {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.modules.druid.DruidInitCmd;

  import bobo.modules.giftPad.GiftPadInitCmd;
  import bobo.modules.giftPad.GiftPadMediator;
  import bobo.modules.giftPad.GiftPadView;
  import bobo.modules.left.LeftInitCmd;
  import bobo.modules.paladin.PaladinCmd;
  import bobo.modules.paladin.PaladinMediator;
  import bobo.modules.paladin.PaladinView;
  import bobo.modules.sceneBg.SceneBgInitCmd;
  import bobo.modules.sceneBg.SceneBgMediator;
  import bobo.modules.sceneBg.SceneBgView;
  import bobo.modules.video.VideoInitCmd;


  import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
  import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
  import robotlegs.bender.framework.api.IConfig;

  public class ModulesConfig implements IConfig {
    [Inject]
    public var cmdMap:IEventCommandMap;
    [Inject]
    public var medMap:IMediatorMap;
    public function ModulesConfig() {
    }

    public function configure():void {
      medMap.map(SceneBgView).toMediator(SceneBgMediator);

      medMap.map(PaladinView).toMediator(PaladinMediator);
      medMap.map(GiftPadView).toMediator(GiftPadMediator);


      cmdMap.map(SimpleType.SCENE_BG,SimpleEvent).toCommand(SceneBgInitCmd);
      cmdMap.map(SimpleType.VIDEO_INIT,SimpleEvent).toCommand(VideoInitCmd);
      cmdMap.map(SimpleType.LEFT_INIT,SimpleEvent).toCommand(LeftInitCmd);
      cmdMap.map(SimpleType.DRUID_INIT,SimpleEvent).toCommand(DruidInitCmd);
      cmdMap.map(SimpleType.PALADIN_INIT,SimpleEvent).toCommand(PaladinCmd);
      cmdMap.map(SimpleType.GIFT_PAD_INIT,SimpleEvent).toCommand(GiftPadInitCmd);
    }
  }
}
