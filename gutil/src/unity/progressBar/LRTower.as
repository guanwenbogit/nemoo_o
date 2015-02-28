/**
 * Created by wbguan on 2015/2/28.
 */
package unity.progressBar {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class LRTower extends Sprite{
    private var _max:int = 10;
    private var _floor:int = 0;
    private var _floors:Vector.<Bitmap> = new Vector.<Bitmap>();
    private var _pic:BitmapData;;
    private var _margin:int;
    private var _main:Bitmap;
    private var _h:int = 0;
    private var s:Sprite = new Sprite();

    public function LRTower(pic:DisplayObject,margin:int = 0,max:int = 10) {
      _margin =margin;
      _max = max;
      if(pic is Bitmap){
        _pic = (pic as Bitmap).bitmapData.clone();
      }else{
        _pic = new BitmapData(pic.width,pic.height,true,0x11000000);
        _pic.draw(pic);
      }
      _h = this._max*(_pic.height+this._margin)-_margin;
      _main = new Bitmap();
      this.addChild(_main);
    }

    public function setMax(max:int):void{
      this._max = max;
    }
    public function getPreRender():DisplayObject{
      var bit:Bitmap;
      gc();
      for(var i:int = 0 ;i<this._floor;i++){
        bit = getBitmap();
        s.addChildAt(bit,0);
        bit.y = i * (_margin + bit.height);
        bit.x = int(Math.random()*2);
      }
      return s;
    }
    private function gc():void{
      while (s.numChildren > 0) {
        var tmp:Bitmap = s.removeChildAt(0) as Bitmap;
        this._floors.push(tmp);
      }
      s.x = s.y = 0;
    }
    public function render():void{
      for(var i:int = 0 ;i<this._floor;i++){
        var bit:Bitmap = getBitmap();
        s.addChildAt(bit,0);
        bit.y = i * (_margin + bit.height);
        bit.x = int(Math.random()*2);
      }
      var data:BitmapData
      if(s.numChildren > 0) {
        data = new BitmapData(s.width, s.height, true, 0x00000000);
        data.draw(s);
      }else{
        data = new BitmapData(1, 1, true, 0x00000000);
      }

        if (this._main.bitmapData != null) {
          this._main.bitmapData.dispose();
          this._main.bitmapData = null;
        }
        this._main.bitmapData = data;
        this._main.y = _h - this._main.height;

      gc();
    }

    private function getBitmap():Bitmap{
      var result:Bitmap;
      if(this._floors.length > 0){
        result = this._floors.pop() as Bitmap;
      }else{
        result = new Bitmap();
        result.bitmapData = _pic;
      }
      return result;
    }

    public function setFloor(num:int):void{
      _floor = num>_max?_max:num;
    }

    public function get h():int {
      return _h;
    }

    public function get floor():int {
      return _floor;
    }
  }
}
