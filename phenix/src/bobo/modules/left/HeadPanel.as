/**
 * Created by wbguan on 2015/9/1.
 */
package bobo.modules.left {
  import com.util.ui.unity.LRHeadPic;
  import com.util.ui.unity.NButton;

  import flash.display.DisplayObject;

  import flash.display.Sprite;

  import tools.uiProvider.NOrg;

  import tools.uiProvider.NProvider;

  public class HeadPanel extends Sprite {
    private var _pic:LRHeadPic;

    public function get loginBtn():NButton {
      return _loginBtn;
    }

    public function get regBtn():NButton {
      return _regBtn;
    }

    private var _loginBtn:NButton;
    private var _regBtn:NButton;
    private var _org:NOrg;
    public function HeadPanel() {
      super();
    }
    public function init(url:String):void{
      _org = NProvider.getOrg(url);
      if(_org != null){
        _loginBtn = _org.getBtn("login");
        _regBtn = _org.getBtn("reg");
        _pic = new LRHeadPic()
      }
    }


    public function setAvatar(param:DisplayObject):void{
      if(_pic!=null) {
        _pic.setPic(param);
      }
    }
    private function clear():void{
      while(numChildren>0){
        this.removeChildAt(0)
      }
    }
    public function guestMode():void{
      clear();
      this.addChild(_regBtn);
      this.addChild(_loginBtn);
      this._regBtn.x = this._loginBtn.x = 10;
      _loginBtn.y = 15;
      _regBtn.y = 35;
    }
    public function userMode():void{
      clear();
      this.addChild(_pic);
      _pic.x = 10;
      _pic.y = 15;
    }

  }
}
