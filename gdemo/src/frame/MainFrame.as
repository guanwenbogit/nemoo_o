/**
 * Created by wbguan on 2015/1/26.
 */
package frame {
  import flash.display.Sprite;

  import system.mould.Moulds;

  public class MainFrame extends Sprite {
    public function MainFrame() {
      super();
    }
    public function init():void{
      Moulds.instance.register(HelloWorldMould);
      Moulds.instance.register(ByeMould);
    }
  }
}
