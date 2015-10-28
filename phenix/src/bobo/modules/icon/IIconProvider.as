/**
 * Created by wbguan on 2015/10/16.
 */
package bobo.modules.icon {
  import flash.display.DisplayObject;

  public interface IIconProvider {
    function getWealthIcon(lvl:int):DisplayObject;
    function getAnchorLvlIcon(lvl:int):DisplayObject;


  }
}
