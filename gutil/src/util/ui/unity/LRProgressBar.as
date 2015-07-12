/**
 * Created by wbguan on 2015/2/28.
 */
package util.ui.unity {
  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.Sprite;

  public class LRProgressBar extends Sprite{
    protected const _max:uint = 100;
    protected var _progress:uint = 0;
    private var _bg:DisplayObject;
    private var _core:DisplayObject;
    private var _bar:DisplayObject;
    private var _distance:int = 0;
    private var _header:MovieClip;
    public function LRProgressBar(distance:int){
      _distance = distance;
    }
    public function setBg(param:DisplayObject,x:int = 0,y:int = 0):void{
      if(_bg!=null && this.contains(_bg)){
        this.removeChild(this._bg);
      }
      _bg = param;
      this.addChildAt(_bg,0);
      _bg.x = x;
      _bg.y = y;
    }
    public function setCore(param:DisplayObject,header:MovieClip = null,x:int = 0,y:int = 0):void{
      if(this._core != null && this.contains(this._core)){
        this.removeChild(this._core);
      }
      _header = header;
      this._core = param;
      this.addChild(this._core);
      _core.x = x;
      _core.y = y;
    }
    public function setBar(bar:DisplayObject,x:int = 0,y:int = 0):void{
      if(this._bar != null && this.contains(this._bar)){
        this.removeChild(this._bar);
      }
      this._bar = bar;
      this._core.mask = this._bar;
      this.addChild(this._bar);
      _bar.x = x;
      _bar.y = y;
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
      var scale:Number = 1.0*this._progress/this._max;
      this._bar.width = int(this._distance * scale);
      if(this._header != null){
        this.addChild(this._header);
        this._header.x = this._bar.width;
      }
    }
    public function dispose():void{
      if(this._header != null){
        this._header.stop();
      }
    }
  }
}
