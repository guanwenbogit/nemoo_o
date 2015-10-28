/**
 * Created by wbguan on 2015/9/17.
 */
package bobo.plugins.druid.txt.info {
  import bobo.modules.user.UserInfoModel;

  import flash.text.TextFormat;


  public class ChatInfo extends Object {
    private var _from:UserInfoModel;
    private var _to:UserInfoModel;
    private var _content:String = "";
    private var _bgName:String = "" ;
    private var _tf:TextFormat;
    private var _type:String = "";
    private var _date:String= "";
    private var _icons:Array =[];
    private var _title:String = "";

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
      return _bgName = "chat1";
    }

    public function set tf(value:TextFormat):void {
      _tf = value;
    }

    public function set bgName(value:String):void {
      _bgName = value;
    }

    public function get type():String {
      return _type;
    }
  }
}
