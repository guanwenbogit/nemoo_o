package {
  /**
   * @author sytang
   */
  public class CustomProperties {
//    public static const ROOM_ID:String = "100397";
//    public static const USER_ID:String = "1908967765305120956";
//roomModel.roomId = 100690;
//        roomModel.roomId = 100698;
//        roomModel.roomId = 100015;
//        roomModel.roomId = 100397;
//        roomModel.roomId = 100658;

//        roomModel.selfModel.userId = "1876469479003268673";
//        roomModel.selfModel.userId = "1908967765305120956";
//        roomModel.selfModel.userId = "-911287405687377583";//836819847767349645 6881432443421840672
//        roomModel.selfModel.userId = "temp2198579911";//836819847767349645 6881432443421840672,temp21985799,-911287405687377583
//        roomModel.selfModel.userId = "3658826661965192363";//836819847767349645 6881432443421840672
//        roomModel.selfModel.userId = "1746668431202788406";//-8474224627841718820 4802615418367376497 32628370066129811 7620745150960324069 -2660883297686620
    //----------------------------------
    //  roomId
    //----------------------------------
    private static var _roomId:int;
    public static var isFamily:Boolean = false;
    public static function get roomId():int {
      return _roomId;
    }
    
    //----------------------------------
    //  userId
    //----------------------------------s
    private static var _userId:String;
    public static function get userId():String {
      return _userId;
    }

    public static function init():void {
      _roomId = 100027 ;
      _userId = "836819847767349645";
    }
    public static function get params():Object{
      return {
        roomId:100397,
        userId:"836819847767349645"
      }
    }
  }
}
