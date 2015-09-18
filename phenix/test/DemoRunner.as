/**
 * Created by wbguan on 2015/9/18.
 */
package {
  import bobo.modules.chat.ChatViewDemo;

  import flash.display.Sprite;

  public class DemoRunner extends Sprite {
    public function DemoRunner() {
      super();
      trace("demo start");
      this.addChild(new ChatViewDemo());
    }
  }
}
