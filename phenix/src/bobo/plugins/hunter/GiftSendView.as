/**
 * Created by wbguan on 2015/10/20.
 */
package bobo.plugins.hunter {
  import com.util.ui.list.LRRadioBtnList;
  import com.util.ui.unity.BaseBtn;

  import flash.display.Sprite;

  public class GiftSendView extends Sprite {
    private var _radio:LRRadioBtnList;
    private var _btns:Array = [];
    private var _nextBtn:BaseBtn;
    private var _prevBtn:BaseBtn;
    private var _chargeBtn:BaseBtn;
    private var _sendBtn:BaseBtn;
    private var _comboBtn:BaseBtn;
    public function GiftSendView() {
      super();
    }

    public function addBtn(btn:BaseBtn):void{
      _btns.push(btn);
    }
    public function render():void{
      for each(var btn:BaseBtn in _btns) {
        _radio.appendBtn(btn);
      }
    }

  }
}
