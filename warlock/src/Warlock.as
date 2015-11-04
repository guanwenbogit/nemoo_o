/**
 * Created by wbguan on 2015/10/28.
 */
package {
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.external.ExternalInterface;

  public class Warlock extends Sprite {
    public function Warlock() {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, onStage);
      trace("loading");
    }

    private function onStage(event:Event):void {
      FlashCore.instance.reg("sendFunc",appendGiftElement);
      FlashCore.instance.reg("appendMountsEle",appendMountsEle);
      FlashCore.instance.reg("append",append);
      if(ExternalInterface.available) {
        ExternalInterface.call("inited");
      }else{
        ExternalInterface.call("alert","false");
      }
    }
    public function appendGiftElement(param:int):void{

        ExternalInterface.call("console.info","appendGiftElement");

    }
    public function appendMountsEle(...args):void{

    }
    public function append(...args):void{

    }
  }
}
