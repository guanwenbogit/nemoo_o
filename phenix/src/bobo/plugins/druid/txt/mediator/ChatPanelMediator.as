/**
 * Created by wbguan on 2015/9/21.
 */
package bobo.plugins.druid.txt.mediator {
  import bobo.framework.event.SimpleEvent;
  import bobo.framework.event.SimpleType;
  import bobo.plugins.druid.txt.ChatConstants;
  import bobo.plugins.druid.txt.ChatElementBuilder;
  import bobo.plugins.druid.txt.ChatModel;
  import bobo.plugins.druid.txt.ChatModelEventType;
  import bobo.plugins.druid.txt.ChatPanel;
  import bobo.plugins.druid.txt.info.ChatInfo;

  import com.plugin.log.LogUtil;

  import flash.display.Loader;
  import flash.events.Event;
  import flash.events.IEventDispatcher;
  import flash.utils.getTimer;

  import robotlegs.bender.bundles.mvcs.Mediator;

  import tools.uiProvider.NProvider;

  public class ChatPanelMediator extends Mediator {
    [Inject]
    public var view:ChatPanel;
    [Inject]
    public var dispatcher:IEventDispatcher;
    [Inject]
    public var chatModel:ChatModel;
    [Inject]
    public var chatBuilder:ChatElementBuilder;
    private var _infoBuffer:Vector.<ChatInfo> = new <ChatInfo>[];
    private var _count:int = 500;
    override public function initialize():void {
      super.initialize();
      NProvider.loadSwf(ChatConstants.CHAT_SWF,onLoaded);
    }

    private function onLoaded(loader:Loader):void {
      view.init(null);
      var infos:Vector.<ChatInfo> = chatModel.getLastPublish(200);
      setPanel(infos);
      dispatcher.addEventListener(ChatModelEventType.APPEND_PUBLISH_ARR,onAppendPublish);
      dispatcher.addEventListener(ChatModelEventType.APPEND_WHISPER_ARR,onAppendWhisper);
//      view.addEventListener(Event.ENTER_FRAME, onEnterFrame);
    }

    private function render():void {
      if(!view.hasEventListener(Event.ENTER_FRAME)) {
        view.addEventListener(Event.ENTER_FRAME, onRender);
      }
    }

    private function onRender(event:Event):void {
      var param:Vector.<ChatInfo> = _infoBuffer.splice(0,5);
      if(param != null && param.length>0){
        view.appendElements(chatBuilder.getElements(param));
      }else{
        view.removeEventListener(Event.ENTER_FRAME, onRender);
      }
      LogUtil.info("onRender param len : " + param.length);
    }

//    private function onEnterFrame(event:Event):void {
//      var timer:Number = getTimer();
//      var len:int = int(Math.random()*10)+5;
//      for(var i:int = 0 ;i<len;i++){
//        chatModel.publishSimpleContent("chat : "+i+" | "+timer+"",null,"","",null,null);
//      }
//      if(_infoBuffer.length>=_count){
//        view.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
//      }
//    }

    private function onAppendWhisper(event:SimpleEvent):void {
      var infos:Vector.<ChatInfo> = event.data as Vector.<ChatInfo>;
      setPanel(infos);
    }

    private function onAppendPublish(event:SimpleEvent):void {
      var infos:Vector.<ChatInfo> = event.data as Vector.<ChatInfo>;
      setPanel(infos);
    }
    private function setPanel(infos:Vector.<ChatInfo>):void{
      _infoBuffer = _infoBuffer.concat(infos);
      render();
      LogUtil.info("info buffer len : " + _infoBuffer.length,"ChatPanelMediator");
    }
    private function clearBuffer():void{
      _infoBuffer = new <ChatInfo>[];
    }
    override public function destroy():void {
      super.destroy();
      dispatcher.removeEventListener(ChatModelEventType.APPEND_PUBLISH_ARR,onAppendPublish);
      dispatcher.removeEventListener(ChatModelEventType.APPEND_WHISPER_ARR,onAppendWhisper);
    }

    public function ChatPanelMediator() {
      super();
    }
  }
}
