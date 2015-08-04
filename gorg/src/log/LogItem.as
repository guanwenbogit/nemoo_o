/**
 * Created by wbguan on 2015/7/15.
 */
package log {
  import flash.text.TextField;

  import util.ui.scrollbar.LRScrollerElement;

  public class LogItem extends LRScrollerElement {

    public function LogItem() {
      super();
    }

    override protected function bind():void {
      var info:LogInfo = this.data as LogInfo;
      var str:String = LogUtil.getStrByInfo(info);

    }
  }
}
