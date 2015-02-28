/**
 * Created by wbguan on 2015/2/28.
 */
package unity.progressBar {
  public class StepProgressBar extends LRProgressBar {
    private var _step:int = 0;
    public function StepProgressBar(step:int) {
      super();
      this._step = step > this._max?this._max:step;
    }

    override public function setProgress(param:uint):void {
      super.setProgress(param);
    }
  }
}
