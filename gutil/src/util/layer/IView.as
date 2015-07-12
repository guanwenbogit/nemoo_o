/**
 * Created by wbguan on 2015/5/4.
 */
package util.layer {
  import flash.display.DisplayObject;

  public interface IView {
    function hide():void;
    function show():void;
    function get layerName():String;
    function set layerName(value:String):void;
    function get view():DisplayObject;
  }
}
