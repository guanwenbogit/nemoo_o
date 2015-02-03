/**
 * Created by wbguan on 2015/1/28.
 */
package system.util.container {
  public interface IContainer {
    function setParent(parent:IContainer);
    function addChild(child:Object):void;
    function addChildAt(child:Object,index:int):void;
    function removeChild(child:Object):void;
    function removeChileAt(index:int):Object;
    function get x():Number;
    function get y():Number;
    function get width():Number;
    function get height():Number;
    function get core():Object;
    function contains(view:Object):Boolean;
    function remove():void;
    function show():void
    function addEventListener(type:String, callBack:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
    function removeEventListener(type:String, callBack:Function):void
  }
}
