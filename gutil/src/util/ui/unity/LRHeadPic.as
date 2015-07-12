/**
 * Created by wbguan on 2015/3/5.
 */
package util.ui.unity {
  import flash.display.DisplayObject;
  import flash.display.Shape;
  import flash.display.Sprite;

  public class LRHeadPic extends Sprite {
    private var _holder:Sprite = new Sprite();
    private var _holderMask:DisplayObject;
    private var _bolder:DisplayObject;
    public function LRHeadPic() {
      super();
      defMask();
    }
    private function defMask():void{
      var shape:Shape = new Shape();
      shape.graphics.beginFill(0x000000,1);
      shape.graphics.drawCircle(25, 25, 25);
      shape.graphics.endFill();
      shape.x = shape.y = 1;
      this.setMask(shape);
      this.addChild(this._holder);
    }
    public function setMask(mask:DisplayObject):void{
      if(this._holderMask != null && this.contains(this._holderMask)){
        this.removeChild(this._holderMask);
      }
      this._holderMask = mask;
      this._holder.mask = this._holderMask;
      this.addChild(this._holderMask);
    }

    public function setPic(pic:DisplayObject):void{
      while(_holder.numChildren>0){
        this._holder.removeChildAt(0);
      }
      this._holder.addChild(pic);

    }

    public function dispose():void {
      while(numChildren > 0){
        this.removeChildAt(0)
      }
      _holder.mask = null
    }

    public function get bolder():DisplayObject {
      return _bolder;
    }

    public function set bolder(value:DisplayObject):void {
      if(this._bolder != null && this.contains(this._bolder)){
        this.removeChild(this._bolder);
      }
      _bolder = value;
      this.addChild(this._bolder);
    }
  }
}
