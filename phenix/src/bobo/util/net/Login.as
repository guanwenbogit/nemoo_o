/**
 * Created by wbguan on 2015/4/28.
 */
package bobo.util.net {
  import flash.errors.IOError;
  import flash.events.Event;
  import flash.events.EventDispatcher;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLLoader;
  import flash.net.URLRequest;
  import flash.net.URLRequestMethod;
  import flash.net.URLVariables;

  public class Login extends EventDispatcher {
    private var _data:Object;
    public function Login() {
      super();
    }
    public function login(url:String,userId:String,roomId:int):void{
      var loader:URLLoader = new URLLoader();
      var req:URLRequest = new URLRequest();
      req.url = url;
      req.method = URLRequestMethod.POST;
      var requestData:URLVariables = new URLVariables();
      requestData.data = JSON.stringify({
        "userId":userId, "roomId":roomId
      });
      req.data = requestData;
      loader.addEventListener(Event.COMPLETE,onComplete);
      loader.addEventListener(IOErrorEvent.IO_ERROR, ioError);
      loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);
      loader.load(req);
    }

    public function ioError(event:IOErrorEvent):void {
      trace("Login, "+event);
    }

    public function securityError(event:SecurityErrorEvent):void {
      trace("Login, "+event);
    }

    private function onComplete(event:Event):void {
      var loader : URLLoader = event.currentTarget as URLLoader;
      _data = JSON.parse(loader.data)["data"];
      this.dispatchEvent(new Event(Event.COMPLETE));
    }

    public function get data():Object {
      return _data;
    }
  }
}
