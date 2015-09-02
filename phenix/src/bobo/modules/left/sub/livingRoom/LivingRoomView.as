/**
 * Created by wbguan on 2015/9/2.
 */
package bobo.modules.left.sub.livingRoom {
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;

  public class LivingRoomView extends PreLoadingView {
    private var _loading:DisplayObject;
    private var w:int = 500;
    private var h:int = 768;
    public function LivingRoomView() {
      super(_loading, w, h);
    }
  }
}
