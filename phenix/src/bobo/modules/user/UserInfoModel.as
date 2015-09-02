/**
 * Created by wbguan on 2015/8/21.
 */
package bobo.modules.user {
  public class UserInfoModel {
    private var _userId:String = "";
    public function UserInfoModel() {
    }

    public function get userId():String {
      return _userId;
    }

    public function set userId(value:String):void {
      _userId = value;
    }
  }
}
