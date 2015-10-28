/**
 * Created by wbguan on 2015/8/21.
 */
package bobo.modules.user {
  public class UserInfoModel {
    private var _userId:String = "";
    private var _nick:String = "";
    private var _empty:Boolean = false;
    private var _wealthLevel:int = 0;
    public function UserInfoModel(obj:Object) {
      if(obj){
        _userId = obj["userId"];
        _nick = obj["nick"] ||"nemo";
        _wealthLevel = obj["wealthLevel"] || 0;
        _empty = true;
      }
    }

    public function get userId():String {
      return _userId;
    }

    public function set userId(value:String):void {
      _userId = value;
    }

    public function get nick():String {
      return _nick;
    }

    public function get empty():Boolean {
      return _empty;
    }
    public function clone():UserInfoModel{
      var result:UserInfoModel;

      return result;
    }
  }
}
