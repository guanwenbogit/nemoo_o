/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.modules.main {
  import bobo.modules.room.IRoom;
  import bobo.modules.user.UserInfoModel;

  public class RoomModel extends Object implements IRoom{
    private var _roomId:int = 0;
    private var _self:UserInfoModel;
    private var _token:String = "";
    private var _inited:Boolean = false;

    public function RoomModel() {
      super();
    }

    public function get roomId():int {
      return _roomId;
    }

    public function set roomId(value:int):void {
      _roomId = value;
    }

    public function get self():UserInfoModel {
      return _self;
    }

    public function set self(value:UserInfoModel):void {
      _self = value;
    }

    public function get token():String {
      return _token;
    }

    public function set token(value:String):void {
      _token = value;
    }

    public function init(respBody:Object):void {
      _inited = true;
    }

    public function get inited():Boolean {
      return _inited;
    }
  }
}
