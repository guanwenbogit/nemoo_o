/**
 * Created by wbguan on 2015/10/16.
 */
package bobo.modules.icon {
  import flash.display.DisplayObject;

  public class IconProvider extends Object implements IIconProvider{
    public function IconProvider() {
      super();
    }

    public function getWealthIcon(lvl:int):DisplayObject {
      return null;
    }

    public function getAnchorLvlIcon(lvl:int):DisplayObject {
      return null;
    }
  }
}
