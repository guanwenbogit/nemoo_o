/**
 * Created by wbguan on 2015/4/29.
 */
package bobo.util.net.event {
  import flash.events.Event;

  public class MessageSimpleEvent extends Event {
    public var respCode:int;
    public var respNo:uint;
    public var respHeader:Object;
    public var respBody:Object;
    public function MessageSimpleEvent(type:String,
                                 code:int,No:int,header:Object,body:Object,
                                 bubbles:Boolean = false, cancelable:Boolean = false) {
      super(type, bubbles, cancelable);
      respCode = code;
      respNo = No;
      respHeader = header;
      respBody = body;
    }

    override public function clone():Event {
      return new MessageSimpleEvent(type,respCode,respNo,respHeader,respBody,bubbles,cancelable);
    }
  }
}
