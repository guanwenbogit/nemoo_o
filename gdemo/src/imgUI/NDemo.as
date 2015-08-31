/**
 * Created by wbguan on 2015/8/31.
 */
package imgUI {
  import flash.display.Sprite;

  import tools.uiProvider.NOrg;

  import util.ui.bitmapSheet.SheetPool;
  import util.ui.bitmapSheet.SheetPoolElement;
  import util.ui.unity.LRButton;
  import util.ui.unity.NButton;

  public class NDemo extends Sprite {
    private var _pool:SheetPool;
    public function NDemo() {
      super();
      _pool = new SheetPool();
      init();
    }
    private function init():void{
      _pool.getSheetMap("back_btn.png","back_btn.json",onBack);
    }

    private function onBack(element:SheetPoolElement):void {
      var norg:NOrg = new NOrg(element);
      var btn:NButton = norg.getBtn("back");
      this.addChild(btn);
    }
  }
}
