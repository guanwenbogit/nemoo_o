package animation.grid {
  import flash.geom.Rectangle;
  import flash.geom.Matrix;
  import flash.display.BitmapData;
  import flash.display.Bitmap;
  import flash.ui.Keyboard;
  import flash.events.KeyboardEvent;
  import flash.geom.Point;
  import flash.events.MouseEvent;
  import flash.display.DisplayObject;
  import flash.display.Sprite;
  /**
   * @author wbguan
   */
  public class VertexProvider extends Sprite {
    private var _gird:Grid;
    private var _bg:DisplayObject;
    private var _vertex:Array;
    private var _mouse:Sprite;
    private var _tile:Sprite;
    private var _bit:Bitmap;
    private var _bitData:BitmapData;
    private var _oColor:uint;
    public function VertexProvider(bg:DisplayObject,grid:Grid) {
      this._gird = grid;
      this._bg = bg;
      this.addChild(this._gird.getView());
      if(bg is Bitmap){
        this._bit = this._bg  as Bitmap;
//        this._bit.x = (this.width - this._bg.width)/2;
//        this._bit.y = (this.height - this._bg.height)/2;
        _bitData = this._bit.bitmapData;
      }else{
        var matrix:Matrix = new Matrix();
//        matrix.tx= (this.width - this._bg.width)/2;
//        matrix.ty = (this.height - this._bg.height)/2;
        _bitData = new BitmapData(this.width, this.height);
        this._bit = new Bitmap();
        _bitData.draw(this._bg,matrix,null,null,null,true);
        _bit.bitmapData = this._bitData;
      }
      this.addChildAt(this._bit,0);
      this._oColor = this._bitData.getPixel32(0, 0);
      this.reset();
      this.createVertexAdc();
    }

    private function createVertexAdc():void{
      var unitSize:Number = this._gird.uintSize;
      var nextPoint:Point = new Point();
      var rect:Rectangle;
      for(var i:int ;i < this._gird.total;i++){
        nextPoint = this._gird.getLocationByIndex(i);
        rect = new Rectangle(nextPoint.x,nextPoint.y,unitSize,unitSize);
        var pexl:Vector.<uint> = this._bitData.getVector(rect);
        if(this.isFilled(pexl)){
          var vertex:Object = this.getVertex(pexl);
          vertex["index"] = i;
          this._vertex.push(vertex);
          trace("[VertexProvider/createVertex] : " + i);
        }
      }
    }
    
    private function getVertex(pexl:Vector.<uint>):Object {
      var result:Object;
      var unitSize:Number = this._gird.uintSize;
      var count:int = 0;
      var a:int = 0;
      var b:int = 0;
      var c:int = 0;
      var d:int = 0;
      for each(var color:uint in pexl){
        if(color != this._oColor){
          var rIndex:int = 0;
          var cIndex:int = 0;
          rIndex = Math.floor(count/unitSize);
          cIndex = count%unitSize;
          if(rIndex >=0 && rIndex<Math.floor(unitSize/2)){
            if(cIndex>Math.floor(unitSize/2)){
              b++;
            }else{
              a++;
            }
          }else{
            if(cIndex>Math.floor(unitSize/2)){
              c++;
            }else{
              d++;
            }
          }
        }
        count++;
      }
      var offsetX:int = 0;
      var offsetY:int = 0;
      var max:int = Math.max(a,b,c,d);
        switch(max){
          case a:
          offsetX = Math.floor(unitSize/4);
          offsetY = Math.floor(unitSize/4);
          break;
          case b:
          offsetX = Math.floor(unitSize/4)*3;
          offsetY = Math.floor(unitSize/4);
          break;
          case c:
          offsetX = Math.floor(unitSize/4)*3;
          offsetY = Math.floor(unitSize/4)*3;
          break;
          case d:
          offsetX = Math.floor(unitSize/4);
          offsetY = Math.floor(unitSize/4)*3;
          break;
        }
      result = {offsetX:offsetX,offsetY:offsetY};
      return result;
    }
    
    private function isFilled(pexl:Vector.<uint>):Boolean {
      var result:Boolean = false;
      var count:int = 0;
      for each(var color:uint in pexl){
        if(color != this._oColor){
          count++;
        }
      }
      if(count > pexl.length/10){
        result = true;
      }
      return result;
    }
     
    private function onMove(event : MouseEvent) : void {
      this._mouse.x = this.mouseX - this._mouse.width/2;
      this._mouse.y = this.mouseY - this._mouse.height/2;
      var i:int = this._gird.getIndexByPoint(new Point(this.mouseX,this.mouseY));
      if(_tile != null){
        _tile.alpha = 0.2;
      }
      
    }

    private function onKey(event : KeyboardEvent) : void {
      var speed:Number = 2;
      if(this._bg != null){
        switch(event.keyCode){
          case Keyboard.DOWN:
            this._bg.y +=speed;
            break;
          case Keyboard.RIGHT:
          this._bg.x +=speed;
            break;
          case Keyboard.UP:
           speed = -2;
           this._bg.y +=speed;
           break;
          case Keyboard.LEFT:
            speed = -2;
            this._bg.x +=speed;
            break;
        }
        
      }
    }

    public function reset():void{
      this._vertex = new Array();
    }

    public function get vertex() : Array {
      return _vertex;
    }
    
  }
}
