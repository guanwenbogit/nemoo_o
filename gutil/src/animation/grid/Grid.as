package animation.grid {

  import flash.display.Sprite;
  import flash.geom.Point;

  import util.ui.shape.LRRoundRectangle;

  /**
   * @author wbguan
   */
  public class Grid extends Object {
    //----------------------------------
    //  total
    //----------------------------------
    private var _total:int;
    public function get total():int {
      return _total;
    }
    //----------------------------------
    //  column
    //----------------------------------
    private var _column:int;
    public function get column():int {
      return _column;
    }
    //----------------------------------
    //  uintSize
    //----------------------------------
    private var _uintSize:int;
    public function get uintSize():int {
      return _uintSize;
    }
    private var view:Sprite;
    public function Grid(total:int,column:int,uintSize:int) {
      this._total = total;
      this._column = column;
      this._uintSize = uintSize;
      this.view = new Sprite();
    }
    /*
     * if the index is invaild, it will return null;
     */
    public function getLocationByIndex(index:int):Point{
      var result:Point;
      if(index >= 0 && index <this._total){
        result = new Point();
        var column:int = index % this._column;
        var row:int = index / this._column;
        var x:Number = column * this._uintSize;
        var y:Number = row * this._uintSize;
        result.x = x;
        result.y = y;
      }else{
        trace("[Grid/getLocationByIndex] the index : "+index+"is out of range.");
      }
      return result;
    }
    
    public function getCenterPoint():Point{
      var result:Point = new Point();
      var w:int = this._uintSize * this._column;
      var h:int = this._uintSize * Math.ceil(this._total/this._column);
      result.x = w/2;
      result.y = h/2;
      return result;
    }
    
    public function getCenterIndex():int{
      var result:int = 0;
      result =  Math.floor(this._total/2);
      return result;
    }
    
    public function getIndexByPoint(point:Point):int{
      var result:int = 0;
      var column:int = Math.floor(point.x / this._uintSize);
      var row:int = Math.floor(point.y/this._uintSize);
      result = row * this._column + column;
      return result;
    }
    
    public function getView():Sprite{
      while(this.view.numChildren > 0){
        this.view.removeChildAt(0);
      }
      for(var i:int = 0 ; i < this.total ; i++){
        var rect:LRRoundRectangle = new LRRoundRectangle(_uintSize, _uintSize, 1,0xf0c0f0 * (i%2),0.2);
        this.view.addChild(rect);
        var point:Point = this.getLocationByIndex(i);
        rect.x = point.x;
        rect.y = point.y;
      }
      return this.view;
    }
    
  }
}
