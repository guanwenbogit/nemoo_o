/**
 * Created by wbguan on 2015/1/22.
 */
package richtxt {
  import flash.display.Sprite;

  public class RichTxtDemo extends Sprite {
    private var txt:RichTextField;
    public function RichTxtDemo() {
      super();
      var r:RichGraphics = new Rich();
      txt = new RichTextField(r);
      this.addChild(txt);
      txt.appendTxt("1234[u:smile]\n65");
      txt.insertImg("u:cry");
      txt.y = 100;
    }
  }
}
