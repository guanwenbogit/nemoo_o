/**
 * Created by wbguan on 2015/9/1.
 */
package bobo.modules.left {
  import bobo.modules.hud.HudForm;
  import bobo.modules.left.sub.livingRoom.LivingRoomView;
  import bobo.modules.left.sub.userlist.UserListView;
  import bobo.util.animation.MaskTweenUtil;

  import com.plugin.log.LogUtil;

  import com.util.ui.list.LRRadioBtnEvent;
  import com.util.ui.view.IFold;

  import flash.display.DisplayObject;

  import flash.display.Sprite;
  import flash.events.MouseEvent;
  import flash.geom.Point;

  import robotlegs.bender.bundles.mvcs.Mediator;

  public class FeatureMediator extends Mediator {
    [Inject]
    public var view:FeaturePanel;
    [Inject]
    public var hud:HudForm;
    private var _current:int = -1;
    private var _livingRoom:Sprite;
    private var _userList:Sprite;
    private var _task:Sprite;
    private var _c:Sprite;

    override public function initialize():void {
      super.initialize();
      view.radio.addEventListener(LRRadioBtnEvent.CHANGE_EVENT, onChange);
      view.radio.addEventListener(LRRadioBtnEvent.SELECT_CURRENT_EVENT, onCurrent);
      view.stage.addEventListener(MouseEvent.CLICK, onClickStage, true);
    }

    private function checkTarget(target:DisplayObject, source:Sprite):Boolean {
      var result:Boolean = false;
      if (source != null && target != null) {
        result = ((target == source) || (source.contains(target)));
      }
      return result;
    }

    private function onClickStage(event:MouseEvent):void {
      var target:DisplayObject = event.target as DisplayObject;
      if (checkTarget(target, _livingRoom)
              || checkTarget(target, _userList)
              || checkTarget(target,view)) {
        LogUtil.info("click sub panel ", "FeatureMediator");
      } else {
        onCurrent(null);
      }
    }

    private function onChange(event:LRRadioBtnEvent):void {
      hide();
      _current = int(event.data);
      switchTarget();
      show();
    }

    private function show():void {
      if (_c != null) {
        MaskTweenUtil.moveInto(_c, null, new Point(_c.x - _c.width, 0));
        if (!this.hud.box.contains(_c)) {
          this.hud.box.addChild(_c);
        }
      }
    }

    private function hide():void {
      if (_c != null) {
        MaskTweenUtil.moveOut(_c, null, new Point(_c.x - _c.width, 0))
      }
    }

    private function switchTarget():void {
      switch (_current) {
        case 0:
          livingRoom();
          break;
        case 2:
          userList();
          break;
        case 3:
          hide();
          _c = null;
          break;
        default :
          hide();
          _c = null;
          break;
      }
    }

    private function livingRoom():void {
      if (_livingRoom == null) {
        _livingRoom = new LivingRoomView()
      }
      _livingRoom.x = 0;
      _livingRoom.y = 0;
      _c = _livingRoom;

    }

    private function userList():void {
      if (_userList == null) {
        _userList = new UserListView()
      }
      _userList.x = 0;
      _userList.y = 0;
      _c = _userList;
    }

    override public function destroy():void {
      super.destroy();
      view.radio.removeEventListener(LRRadioBtnEvent.CHANGE_EVENT, onChange);
      view.radio.removeEventListener(LRRadioBtnEvent.SELECT_CURRENT_EVENT, onCurrent);
    }

    public function FeatureMediator() {
      super();
    }

    private function onCurrent(event:LRRadioBtnEvent):void {
      view.radio.setCurrent(-1);
      hide();
      _c = null;
    }
  }
}
