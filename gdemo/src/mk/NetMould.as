/**
 * Created by wbguan on 2015/1/29.
 */
package mk {
  import network.NetWork;
  import network.NetWorkEvent;

  import system.api.hub.HubPool;
  import system.mould.Mould;

  public class NetMould extends Mould {
    private var _net:NetWork;
    public function NetMould(hubPool:HubPool) {
      super(hubPool);
    }

    override protected function init():void {
      super.init();
      _net = new NetWork();
      _net.connect();
      _net.dispatcher.addEventListener(NetWorkEvent.CONNECTED,onConnect);
    }

    private function onConnect(event:NetWorkEvent):void {
      trace("connected !!!");
      this.outside.getHubByName(MKAppConstant.NET_WORK_SEND).listen(onSend);
      _net.dispatcher.addEventListener(NetWorkEvent.RECEIVE_DATA,onReceive);
    }

    private function onSend(...args):void {
      trace("net mould send ");
      for each(var param:Object in args){
        trace(param);
        this._net.send(param.toString());
      }
    }

    private function onReceive(event:NetWorkEvent):void {
      trace("net mould recv");
      this.outside.getHubByName(MKAppConstant.NET_WORK_RECV).publish(event.data);
    }
  }
}
