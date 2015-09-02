/**
 * Created by wbguan on 2015/8/19.
 */
package bobo.config {
  import bobo.framework.event.SimpleType;

  public class FileConfig extends Object {
    public static const commonFiles:Array = [{name:SimpleType.LEFT_INIT,url:"n_left.png,n_left.json"}];
    public static const modulesFiles:Array = [];
    public function FileConfig() {
      super();
    }
  }
}
