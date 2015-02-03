/**
 * Created by wbguan on 2015/1/26.
 */
package frame {
  import system.api.hub.Hub;
  import system.api.hub.HubPool;
  import system.mould.Mould;

  public class HelloWorldMould extends Mould {
    public function HelloWorldMould() {
      super();
    }

    override protected function init():void {
      super.init();
      trace("hell world");
      HubPool.instance.getHubByName("Hello").listen(onHello)
      HubPool.instance.getHubByName("Hello").publish(1);
    }

    private function onHello(i:int):void {
      trace("listen "+ i +"!!!");
    }
  }
}
