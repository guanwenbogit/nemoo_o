/**
 * Created by wbguan on 2015/1/27.
 */
package network {
  import flash.events.EventDispatcher;
  import flash.utils.setTimeout;

  public class NetWork extends Object {
    private var _dispatcher:EventDispatcher;
    public function NetWork() {
      super();
      this._dispatcher = new EventDispatcher();
    }
    public function connect():void{
     setTimeout(connected,2000);
    }
    public function send(param:String):void{
      setTimeout(receive,5000,param);
    }
    private function connected():void{
      this.dispatcher.dispatchEvent(new NetWorkEvent(NetWorkEvent.CONNECTED,null));
    }
    private function receive(param:String):void{
      this._dispatcher.dispatchEvent(new NetWorkEvent(NetWorkEvent.RECEIVE_DATA,param));
    }
    public function get dispatcher():EventDispatcher {
      return _dispatcher;
    }

  }
}
