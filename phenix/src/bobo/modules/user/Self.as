/**
 * Created by wbguan on 2015/10/15.
 */
package bobo.modules.user {
  public class Self extends Object implements ISelfInfo{
    private var _user:UserInfoModel = new UserInfoModel(null);
    public function Self() {
      super();
    }

    public function init(user:UserInfoModel):void{
      _user = user;
    }

    public function get userId():String {
      return _user.userId;
    }

    public function get nick():String {
      return _user.nick;
    }
  }
}
