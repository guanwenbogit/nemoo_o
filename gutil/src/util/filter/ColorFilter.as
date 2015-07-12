/**
 * Created by wbguan on 2015/5/28.
 */
package util.filter {
  import flash.filters.ColorMatrixFilter;

  public class ColorFilter {
    public static function blackFilter():ColorMatrixFilter{
      return  new ColorMatrixFilter([0.3,0.6,0,0,0,0.3,0.6,0,0,0,0.3,0.6,0,0,0,0,0,0,1,0]) ;
    }
    public static function brightness(bright:int = 100):ColorMatrixFilter{
      var result:ColorMatrixFilter;
      result = new ColorMatrixFilter([1,0,0,0,bright,
        0,1,0,0,bright,
        0,0,1,0,bright,
        0,0,0,1,0]);

      return result;
    }
  }
}
