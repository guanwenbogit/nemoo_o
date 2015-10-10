/**
 * Created by wbguan on 2015/4/28.
 */
package bobo.config {
  import bobo.util.net.CryptoToken;

  import com.util.Debug;

  public class InitConfig extends Object {
    public static const W:int = 900;
    public static const H:int = 768;
    public static var url:String = "http://bobotest.live.163.com/loginserver/distribute.do";
    public static var userId:String = "836819847767349645";
    public static var roomId:int = 100397;
    public static var level:String = "";
    public static var tokenStr:String = "a0f2bb21a7d28c798718f79f6429a594";
    public static var fp:String = "";
    public static var token:CryptoToken;
    public static var mode:String = "simple";
    public static const CHARGE_URL:String = "http://www.bobo.com/pay";
    private static var _PAGE_URL:String = "";
    public static var debug:Boolean = false;
    public static var userNum:int = -1;

    public static function get PAGE_URL():String {
      return _PAGE_URL;
    }
    public function InitConfig() {
      super();
    }
    public static function init(obj:Object):void{
      if(CONFIG::LOCALE){

      }else{

      }
      if(obj.hasOwnProperty("debug")&&obj["debug"] == 1){
        debug = true;
      }
      if(!debug&&!CONFIG::LOCALE){
        url = "http://login.bobo.163.com/game/loginserver/distribute.do"
        tokenStr = obj["token"];
        Debug.console("TOKEN " + tokenStr);
      }
      roomId = obj.roomId||0;
      userId = obj.userId;
      level = obj.level;
      mode = obj["mode"]||"simple";
      _PAGE_URL ="http://"+ obj["hostkey"]+"/";
      token = new CryptoToken();
      token.gen(tokenStr);
      userNum =obj["userNum"];
    }
    public static function roomShowType():int{
      return 0;
    }
  }
}
