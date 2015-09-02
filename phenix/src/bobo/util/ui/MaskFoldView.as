/**
 * Created by wbguan on 2015/9/1.
 */
package bobo.util.ui {
  import com.greensock.TweenLite;
  import com.util.ui.view.*;
  import com.util.ui.shape.LRRectangle;

  import flash.display.Sprite;
  import flash.geom.Point;

  public class MaskFoldView extends Sprite implements IFold {
    private var _mask:LRRectangle;
    protected var _container:Sprite = new Sprite();
    protected var _end:Point = new Point(0,0);
    protected var _start:Point = new Point(0,0);
    private var _tween:TweenLite;
    public function MaskFoldView() {
      super();
      this.addChild(_container);
    }
    public function setStart(x:int,y:int):void{
      _start.x = x;
      _start.y = y;
      this.x = x;
      this.y = y;
    }
    public function setMask(w:int,h:int):void{
      if(_mask!=null&&_mask.parent!=null){
        _mask.parent.removeChild(_mask);
      }
      this._mask = new LRRectangle(w,h,0xffffff);
      this._container.mask = _mask;
      this.addChild(_mask);
    }
    public function fold():void {
      if(_tween != null && _tween.isActive()){
        _tween.kill();
      }
      _tween = TweenLite.fromTo(_container,0.2,{x:_container.x,y:_container.y},{x:_start.x,y:_start.y});
    }

    public function unfold():void {
      if(_tween != null && _tween.isActive()){
        _tween.kill();
      }
      _tween = TweenLite.fromTo(_container,0.2,{x:_container.x,y:_container.y},{x:_end.x,y:_end.y});
    }

  }
}
