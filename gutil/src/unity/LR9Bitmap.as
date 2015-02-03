package unity {
  import flash.geom.Point;
  import flash.geom.Rectangle;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.display.Bitmap;
  import flash.display.BitmapData;

  /**
   * @author wbguan
   */
  public class LR9Bitmap extends Sprite {
    private var _source:DisplayObject;
    private var _leftTop:Bitmap;
    private var _leftBottom:Bitmap;
    private var _leftCenter:Bitmap;
    private var _centerTop:Bitmap;
    private var _center:Bitmap;
    private var _centerBottom:Bitmap;
    private var _rightTop:Bitmap;
    private var _rightCenter:Bitmap;
    private var _rightBottom:Bitmap;
    private var _sourceBitmap:Bitmap;
    private var _left:int = 0;
    private var _right:int = 0;
    private var _top:int = 0;
    private var _bottom:int = 0;
    private var _ow:int = 0;
    private var _oh:int = 0;
    private var _bg:Bitmap;
    public function LR9Bitmap(source:DisplayObject,left:int,top:int,right:int,bottom:int) {
      this._bg = new Bitmap();
      this._source = source;
      this._ow = this._source.width;
      this._oh = this._source.height;
      if(source is Bitmap){
        this._sourceBitmap = this._source as Bitmap;
      }else{
        var data:BitmapData = new BitmapData(this._ow, this._oh,true,0x00000000);
        data.draw(this._source);
        this._sourceBitmap = new Bitmap(data,"auto",false);
      }
      this._left = left;
      this._top = top;
      this._right = right;
      this._bottom = bottom;
      this._oh = source.height;
      this._ow = source.width;
      initInstance();
      render();
      addToParent();
    }
    
    private function initInstance():void {
      this._leftTop = getBitmap(0, 0, this._left, this._top);
      this._leftCenter = getBitmap(0, this._top, this._left, this._oh - this._top - this._bottom);
      this._leftBottom = getBitmap(0, this._oh - this._bottom, this._left, this._bottom);
      this._centerTop = getBitmap(this._left, 0, this._ow - this._left - this._right, this._top);
      this._centerBottom = getBitmap(this._left, this._oh - this._bottom, this._ow - this._left - this._right, this._bottom);
      this._center = getBitmap(this._left, this._top, this._ow - this._left - this._right, this._oh - this._top - this._bottom);
      this._rightTop = getBitmap(this._ow - this._right, 0, this._right, this._top);
      this._rightCenter = getBitmap(this._ow - this._right, this._top, this._right, this._oh - this._top - this._bottom);
      this._rightBottom = getBitmap(this._ow - this._right, this._oh - this._bottom, this._right, this._bottom);
    }
    private function addToParent():void {
      this.addChild(this._bg);
    }
    private function render():void {
      this._leftCenter.x = 0 ; this._leftCenter.y = this._top;
      this._leftBottom.x = 0 ; this._leftBottom.y = this._leftCenter.y + this._leftCenter.height;
      this._centerTop.x = this._left ; this._centerTop.y = 0;
      this._center.x = this._left ; this._center.y = this._top;
      this._centerBottom.x = this._left ; this._centerBottom.y = this._center.y + this._center.height;
      this._rightTop.x = this._centerTop.x + this._centerTop.width ; this._rightTop.y = 0;
      this._rightCenter.x = this._center.x + this._center.width ; this._rightCenter.y = this._top;
      this._rightBottom.x = this._centerBottom.x + this._centerBottom.width ; this._rightBottom.y = this._rightCenter.y + this._rightCenter.height;
      var sprite:Sprite = new Sprite();
      sprite.addChild(_leftTop);
      sprite.addChild(_leftCenter);
      sprite.addChild(_leftBottom);
      sprite.addChild(_centerTop);
      sprite.addChild(_center);
      sprite.addChild(_centerBottom);
      sprite.addChild(_rightTop);
      sprite.addChild(_rightCenter);
      sprite.addChild(_rightBottom);
      clearBg();
      var data:BitmapData = new BitmapData(sprite.width, sprite.height,true,0x00ffffff);
      data.draw(sprite);
      this._bg.bitmapData = data;
    }

    private function clearBg():void {
      if(this._bg != null){
        if(this._bg.bitmapData!= null){
          this._bg.bitmapData.dispose();
        }
      }
    }
    private function getBitmap(x:int,y:int,w:int,h:int):Bitmap {
      var result:Bitmap ;
      var data:BitmapData = new BitmapData(w, h,true,0x00ffffff);
      data.copyPixels(this._sourceBitmap.bitmapData, new Rectangle(x,y,w,h), new Point(0,0));
      result = new Bitmap(data);
      return result;
    }
    
    override public function set height(value:Number):void{
      var span:Number = value - this._top - this._bottom;
      if(span <= 1){
        span = 1;
      }
      this._center.height = this._leftCenter.height = this._rightCenter.height = span;
      render();
    }
    override public function set width(value:Number):void{
      var span:Number = value - this._left - this._right;
      if(span <= 1){
        span = 1;
      }
      this._center.width = this._centerBottom.width = this._centerTop.width = span;
      render();
    }

    public function get ow():int {
      return _ow;
    }

    public function get oh():int {
      return _oh;
    }
    
  }
}
