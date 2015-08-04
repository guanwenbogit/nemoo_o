/**
 * Created by wbguan on 15/7/11.
 */
package machine {
  import flash.events.Event;
  import flash.events.EventDispatcher;

  public class ExeBase implements IExe {
    private var _dispatcher:EventDispatcher;

    public function ExeBase() {
      this._dispatcher = new EventDispatcher();
    }

    public function execute():void {
    }

    public function setArgs(...args):void {
    }

    public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      this._dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void {
      this._dispatcher.removeEventListener(type, listener, useCapture);
    }

    public function dispatchEvent(event:Event):Boolean {
      return this._dispatcher;
    }

    public function hasEventListener(type:String):Boolean {
      return this._dispatcher.hasEventListener(type);
    }

    public function willTrigger(type:String):Boolean {
      return this._dispatcher.willTrigger(type);
    }

    public function dispose():void {
    }
  }
}
