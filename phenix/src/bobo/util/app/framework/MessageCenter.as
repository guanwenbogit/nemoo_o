/**
 * Created by wbguan on 2015/4/28.
 */
package bobo.util.app.framework {

  import bobo.util.net.event.MessageSimpleEvent;

  import flash.events.IEventDispatcher;

  public class MessageCenter extends Object {
    [Inject]
    public var netWork:NetWork;
    [Inject]
    public var eventDispatcher:IEventDispatcher;
    private var mName:String;
    private var _message:Object;
    public function init(name:String=""):void{
      trace("MSG CENTER" + name);
      mName = name;
      netWork.receiveSignal.add(onReceive);
    }

    private function onReceive(param:String):void {
      try {
        _message = JSON.parse(param);
//        trace("[MSG CENTER RECEIVE ] "+ mName +" |　" + param + " | " );
      }catch(e:Error){
        if(CONFIG::DEBUG){
          throw new Error(e.message+"::" + param);
        }
      }
      if(_message != null){
        parse(_message);
      }
      _message = null;
    }
    private function parse(param:Object):void{
      var responseBody:Object = param["respBody"];
      var respNo:uint = param["respNo"];
      var respCode:int = param["respCode"];
      var respHeader:Object = param["respHeader"];
      var respType:String = param["respType"];
      if(respType!=null) {
        trace("MSG DISPATCH " + mName);
        eventDispatcher.dispatchEvent(new MessageSimpleEvent(respType, respCode, respNo, respHeader, responseBody));
      }
    }
    public function MessageCenter() {
      super();
    }

  }
}
