/**
 * Created by wbguan on 2015/2/28.
 */
package unity.progressBar {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  import flash.geom.Matrix;
  import flash.geom.Vector3D;

  public class LRTowerGroup extends Sprite {
    private var _spans:Vector.<int>;
    private var _towers:Array = [];
    private var _nums:Array;
    private var _main:Bitmap;
    private var _buffer:Sprite = new Sprite();

    public function LRTowerGroup(spans:Vector.<int>,infos:Vector.<LRTowerInfo>) {
      super();
      this._spans = spans;
      if(_spans.length == infos.length) {
        for each(var info:LRTowerInfo in infos) {
          var t:LRTower = new LRTower(info.displayObj, info.margin);
          this._towers.push(t);
        }
        this._main = new Bitmap();
        this.addChild(this._buffer);
      }else{
        throw new Error("LRTowerGroup: the spans length must be equal to infos length")
      }
    }

    public function render():void{
      var i:int = 0;
      for each(var t:LRTower in this._towers){
        var num:int = this._nums[i];
        if(num != t.floor) {
          t.setFloor(num);
          t.render();
          t.x = i * (t.width + 10);
          this._buffer.addChild(t);
        }
        i++;
      }
    }

    public function setNum(num:int):void{
      _nums = [];
      var tmp:int = num;
      for each(var span:int in this._spans){
        var param:int = int(tmp/span);
        tmp = (tmp%span);
        _nums.push(param);
      }
    }

  }
}
