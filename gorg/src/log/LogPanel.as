/**
 * Created by wbguan on 2015/7/15.
 */
package log {
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  import util.ui.scrollbar.LRScrollerList;
  import util.ui.shape.LRRectangle;
  import util.ui.unity.LRButton;

  public class LogPanel extends Sprite {
    private var _list:LRScrollerList;
    private var _bar:LRButton = new LRButton("");
    private var _bg:DisplayObject = new LRRectangle(10,10,0x000000);
    private var _copy:LRButton = new LRButton("copy");

    private var _model:LogModel;
    public function LogPanel(model:LogModel) {
      super();
      _model = model;
      initInstance();
      addToParent();
    }

    private function initInstance():void{
      _list = new LRScrollerList(LogItem,500,300,300,_bar,_bg);
      _list.setBarLocation(490,0);
    }
    public function refresh():void{
      _list.refresh(_model.buffer);
    }
    private function addToParent():void{
      this.addChild(_list);
    }

  }
}
