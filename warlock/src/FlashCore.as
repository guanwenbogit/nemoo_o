/**
 * Created by wbguan on 2015/5/15.
 */
package {
  import flash.events.EventDispatcher;
  import flash.external.ExternalInterface;


  public class FlashCore extends EventDispatcher {
    protected static var _instance:FlashCore;

    public function reg(name:String,callBack:Function):void{
      if(ExternalInterface.available){
        ExternalInterface.call("console.info","reg : " + name);
        try {
          ExternalInterface.addCallback(name, callBack);
        }
        catch (error:Error){

        }
      }
    }

    public static function get instance():FlashCore {
      if(_instance == null){
        _instance = new FlashCore();
      }
      return _instance;
    }
  }
}
