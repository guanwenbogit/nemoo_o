/**
 * Created by wbguan on 2015/9/1.
 */
package bobo.modules.left {
  import com.util.ui.list.LRRadioBtnEvent;
  import com.util.ui.list.LRRadioBtnList;
  import com.util.ui.unity.BaseBtn;
  import com.util.ui.unity.LRRangeContainer;
  import com.util.ui.unity.NButton;

  import flash.display.Bitmap;

  import flash.display.Sprite;

  import tools.uiProvider.NOrg;
  import tools.uiProvider.NProvider;

  public class FeaturePanel extends Sprite {
    private var _hall:BaseBtn;
    private var _shop:BaseBtn;
    private var _userList:BaseBtn;
    private var _game:BaseBtn;
    private var _mission:BaseBtn;
    private var _org:NOrg;
    private var _radio:LRRadioBtnList;
    private var _line:Bitmap;
    public function FeaturePanel() {
      super();
      _radio = new LRRadioBtnList();
    }
    public function init(url:String):void{
      _org = NProvider.getOrg(url);
      if(_org != null){
        _line = _org.getBg("line");
        _hall = _org.getBtn("livingRoom");
        _shop = _org.getBtn("shop");
        _userList = _org.getBtn("userList");
        _game = _org.getBtn("fuli");
        _mission = _org.getBtn("task");
        _radio.appendBtns(_hall,_shop,_userList,_game,_mission);
        _radio.addEventListener(LRRadioBtnEvent.CHANGE_EVENT,onChange);
        this.addChild(_radio);
        var range:LRRangeContainer = new LRRangeContainer(_radio,0,LRRangeContainer.DOWN);
        range.range();
        _line.y = this.height;
        this.addChild(_line)
      }

    }

    private function onChange(event:LRRadioBtnEvent):void {
      var index:int = int(event.data);
      if(index == 1){
        _radio.setCurrent(-1);
      }
    }

    public function get radio():LRRadioBtnList {
      return _radio;
    }
  }
}
