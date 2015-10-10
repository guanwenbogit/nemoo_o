/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.vod {
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;

  public class VodPanel extends PreLoadingView {
    public function VodPanel(loading:DisplayObject, w:int, h:int) {
      super(loading, w, h);
    }
  }
}
