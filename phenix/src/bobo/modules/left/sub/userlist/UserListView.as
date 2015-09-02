/**
 * Created by wbguan on 2015/9/2.
 */
package bobo.modules.left.sub.userlist {
  import com.util.ui.shape.LRRectangle;
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;

  public class UserListView extends PreLoadingView {
    private var _loading:DisplayObject;
    private var w:int = 300;
    private var h:int = 768;
    public function UserListView() {
      super(_loading, w, h);
    }

  }
}
