/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.framework.event {
  public class SimpleType extends Object {
    public static const DASHBOARD_COMPLETE:String = "DASHBOARD_COMPLETE";

    public static const MAIN_SHELL_INIT:String = "MAIN_SHELL_INIT";
    public static const VIDEO_INIT:String = "VIDEO_INIT";
    public static const LEFT_INIT:String = "LEFT_INIT";
    public static const DRUID_INIT:String = "DRUID_INIT";
    public static const SCENE_BG:String = "SCENE_BG";
    public static const PALADIN_INIT:String = "PALADIN_INIT";
    public static const GIFT_PAD_INIT:String = "GIFT_PAD_INIT";


    //===============Druid===============
    /*
    * switch the tab in the Druid
    * dispatch SimpleEvent(DRUID_SWITCH_TAB,index:int);
    * */
    public static const DRUID_SWITCH_TAB:String = "DRUID_SWITCH_TAB";
    /*
     * switch the tab in the Druid
     * dispatch SimpleEvent(DRUID_PUBLISH_MESSAGE,message:Object);
     * message {sender:obj,atUser:obj,message:string,title:string,tf:textFormat }
     * */
    public static const DRUID_PUBLISH_MESSAGE:String = "DRUID_PUBLISH_MESSAGE";

    public function SimpleType() {
      super();
    }
  }
}
