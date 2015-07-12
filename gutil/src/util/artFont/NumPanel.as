package util.artFont {
  import com.util.ui.unity.LRRangeContainer;

  import flash.display.BitmapData;
  import flash.display.Bitmap;
  import flash.display.Sprite;

  /**
   * @author wbguan
   */
  public class NumPanel extends Sprite {
    private var _num:int = 0;
    private var _range:LRRangeContainer;
    private var _bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
    private var _w:int = 0;
    private var _h:int = 0;
    private var _displays:Vector.<Bitmap> = new Vector.<Bitmap>();
    public function NumPanel() {
      _range = new LRRangeContainer(this,0,LRRangeContainer.RIGHT);
    }
    public function render():void {
      for each(var b:Bitmap in this._displays){
        this.addChild(b);
      }
      _range.range();
    }
    public function setNum(num:uint,font:String = FontStyle.NORMAL):void {
      this._num = num;
      clearBitmap();
      var arr:Array = getCharArr();
      for each(var i : int in arr){
        var bitmap:Bitmap = getBitMap();
        var bData:BitmapData = FontSheetManager.instance.getCharBitmapData(i.toString(), font);
        if(bData== null){
          continue;
        }
        bitmap.bitmapData = bData;
        _displays.push(bitmap);
        _w += bitmap.width;
        if(bitmap.height > _h){
          _h = bitmap.height;
        }
      }
    }

    private function getBitMap():Bitmap{
      var result:Bitmap;
      if(_bitmaps.length > 0){
        result = _bitmaps.pop();
      }else{
        result = new Bitmap();
      }
      return result;
    }

    public function clearBitmap():void{
      while(_displays.length>0){
        var b:Bitmap = _displays.pop();
        b.x = 0;
        b.y = 0;
        b.bitmapData.dispose();
        this._bitmaps.push(b);
        if(this.contains(b)){
          this.removeChild(b);
        }
      }
      _w = 0;
      _h = 0;
    }

    private function getCharArr():Array {
      var tmp:int = this._num;
      var result:Array = new Array();
      var unit:int = 0;
      do{
        unit = tmp%10;
        tmp = Math.floor(tmp/10);
        result.unshift(unit);
      }while(tmp > 0);
      return result;
    }

    public function get w():int {
      return _w;
    }

    public function get h():int {
      return _h;
    }
    
  }
}
