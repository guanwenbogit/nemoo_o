/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.plugins.druid.txt.info {
  import bobo.modules.user.UserInfoModel;



  public class ChatInfo extends Object {
    private var _from:UserInfoModel;
    private var _to:UserInfoModel;
    private var _content:String = "";
    private var _bgName:String = "" ;

    public function ChatInfo() {
      super();
    }

    public function get from():UserInfoModel {
      return _from;
    }

    public function get to():UserInfoModel {
      return _to;
    }

    public function get content():String {
      return _content;
    }

    public function set from(value:UserInfoModel):void {
      _from = value;
    }

    public function set to(value:UserInfoModel):void {
      _to = value;
    }

    public function set content(value:String):void {
      _content = value;
    }

    public function get bgName():String {
      return _bgName;
    }
  }
}
