/**
 * Created by wbguan on 2015/3/2.
 */
package unity {
  import flash.geom.Point;
  import flash.geom.Rectangle;

  public class LRRectangleRandom extends Object {
    private var _rec:Rectangle;
    private var _margin:Rectangle;
    private var _seedw:int = 0;
    private var _seedh:int = 0;
    public function LRRectangleRandom(rec:Rectangle,margin:Rectangle) {
      super();
      _rec = rec;
      _margin = margin;
      checkRec();
    }
    public function randomPoint():Point{
      var result:Point = new Point();
      this._seedw = Math.floor(this._rec.width/this._margin.width);
      this._seedh = Math.floor(this._rec.height/this._margin.height);
      result.x = int(Math.random()*_seedw)*this._margin.width + this._rec.x;
      result.y = int(Math.random()*_seedh)*this._margin.height+this._rec.y;
      return result;
    }
    protected function checkRec():void{
      _margin.width = Math.min(this._margin.width,_rec.width);
      _margin.height = Math.min(this._margin.height,_rec.height);
    }
  }
}
