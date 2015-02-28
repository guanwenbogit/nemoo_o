/**
 * Created by wbguan on 2015/2/28.
 */
package unity.progressBar {
  import flash.display.Sprite;

  public class LRProgressBar extends Sprite{
    protected const _max:uint = 100;
    protected var _progress:uint = 0;
    public function LRProgressBar(){
    }

    public function setProgress(param:uint):void{
      this._progress = param > _max ?_max:param;
      this.render();
      if(this._max == this._progress){
        renderMax();
      }
    }

    protected function renderMax():void {

    }

    protected function render():void{

    }
  }
}
