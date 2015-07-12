package util {
  import com.util.reflect.ReflectionUtil;

  import flash.display.DisplayObject;


  public class IconUtil {
    public static function getAnchorLvlIcon(lvl:int):DisplayObject{
      var result:DisplayObject;
      result = ReflectionUtil.getDisplayObj("LR_ANCHOR"+lvl+"_001");
      return result;
    }
    public static function getWEALTHLvlIcon(lvl:int):DisplayObject{
      var result:DisplayObject;
      result = ReflectionUtil.getDisplayObj("LR_WEALTH"+lvl+"_001");
      return result;
    }
  }
}
