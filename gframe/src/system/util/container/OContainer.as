/**
 * Created by wbguan on 2015/1/28.
 */
package system.util.container {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;
  import flash.display.Sprite;
  import flash.events.Event;

  public class OContainer implements IContainer {
    protected var _cp:IContainer;
    protected var _parent:DisplayObjectContainer;
    protected var _core:DisplayObjectContainer;
    public function OContainer(core:DisplayObjectContainer) {
      this._core = core;
    }

    private function onAdded(event:Event):void {
      this._parent = this._core.parent;
    }

    public function addChild(child:Object):void {
      if(child is DisplayObject){
        this._core.addChild(child as DisplayObject);
      }
    }

    public function addChildAt(child:Object, index:int):void {
      if(child is DisplayObject){
        this._core.addChildAt(child as DisplayObject,index);
      }
    }

    public function removeChild(child:Object):void {
      if(child is DisplayObject){
        this._core.removeChild(child as DisplayObject);
      }
    }

    public function removeChileAt(index:int):Object {
      return this._core.removeChildAt(index);
    }

    public function addEventListener(type:String, callBack:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void {
      this._core.addEventListener(type,callBack,useCapture,priority,useWeakReference);
    }

    public function removeEventListener(type:String, callBack:Function):void {
      this._core.removeEventListener(type,callBack);
    }

    public function get x():Number {
      return this._core.x;
    }

    public function get y():Number {
      return this._core.y;
    }

    public function get width():Number {
      return this._core.width;
    }

    public function get height():Number {
      return this._core.height;
    }

    public function get core():Object {
      return this._core;
    }

    public function contains(view:Object):Boolean {
      if(view is DisplayObject) {
        return this._core.contains(view as DisplayObject);
      }else{
        return false;
      }
    }

    public function remove():void {
      if(this._core != null && this._core.parent != null){
        this._core.parent.removeChild(this._core);
      }
    }

    public function show():void {
      if(this._cp != null) {
        this._cp.addChild(this._core);
      }
    }

    public function setParent(parent:IContainer) {
      this._cp = parent;
    }
  }
}
