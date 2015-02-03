/**
 * Created by wbguan on 2015/1/29.
 */
package mk {
  import system.api.hub.HubPool;
  import system.mould.DataMould;
  import system.mould.Mould;

  public class DataSource extends Mould {
    public function DataSource(hubPool:HubPool) {
      super(hubPool);
    }

    override protected function init():void {
      super.init();
      this.outside.getHubByName(MKAppConstant.NET_WORK_RECV).listen(onRecv)
    }

    private function onRecv(...args):void {
      this.bindData(args);
    }

    public function bindData(...args):void{
      var data:String = args[0];
      trace("data bind " + args[0]);
    }

  }
}
