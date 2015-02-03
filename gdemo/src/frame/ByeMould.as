/**
 * Created by wbguan on 2015/1/26.
 */
package frame {
  import system.api.hub.HubPool;
  import system.mould.Mould;

  public class ByeMould extends Mould{

    public function ByeMould() {
      HubPool.instance.getHubByName("Hello").listen(onPub)
    }

    protected function onPub(i:int):void {
      trace("listen ByeMould "+ i +"!!!");
    }
  }
}
