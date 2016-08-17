/**
 * Created by guanwenbo on 2016/8/12.
 */
package bb {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import flashx.textLayout.tlf_internal;

    public class Grid extends Object {
        private var _origin:Point = new Point();
        private var _cellWidth:int = 0;
        private var _cellHeight:int = 0;
        private var _rows:int = 0;
        private var _column:int = 0;
        private var _count:int = 0;

        public function Grid(rows:int, column:int, cellWidth:int, cellHeight:int) {
            super();
            _rows = rows;
            _column = column;
            _cellHeight = cellHeight;
            _cellWidth = cellWidth;
            _count = rows*column;
        }

        public function setParams(rows:int,column:int,cellWidth:int,cellHeight:int):void{
            _rows = rows;
            _column = column;
            _cellHeight = cellHeight;
            _cellWidth = cellWidth;
            _count = rows*column;
        }

        public function getRow(y:int):int{
            var result:int = Math.floor( (y-_origin.y)/_cellHeight);
            if(result >= _rows){
                result = -1;
            }
//            trace("[Grid->getRow 38] y "+y + " | row "+ result);
            return result;
        }

        public function getColumn(x:int):int{
            var result:int = Math.floor( (x-_origin.x)/_cellWidth);
            if(result >= _column){
                result = -1;
            }
//            trace("[Grid->getRow 38] x "+x + " | column "+ result);
            return result;
        }

        public function get bitmap():Bitmap{
            var bitmapData:BitmapData = new BitmapData(_column*_cellWidth,_cellHeight*_rows,true,0x5500f0f0);
            for(var i:int = 0;i<_count;i++){
                var point:Point = this.getPoint(i);
                trace("[Grid->bitmap 59] x|y" + point.x+" | "+point.y);
                bitmapData.fillRect(new Rectangle(point.x,point.y,_cellWidth - 5,_cellHeight - 5),0x55123456);
            }
            var result:Bitmap = new Bitmap(bitmapData);
            result.x = _origin.x;
            result.y = _origin.y;
            return result;

        }

        public function getPoint(index:int):Point{
            var row:int =  int(index/_column);
            var column:int = index%_column;
            var x:int =column*_cellWidth ;
            var y:int = row*_cellHeight;
            return new Point(x,y);
        }

        public function getIndex(x:int,y:int):int{
            var result:int = -1;
            var row:int = this.getRow(y);
            var column:int = this.getColumn(x);
            if(row>-1&&column>-1){
              result = row*_column+column;
            }
            return result;
        }

        public function get cellWidth():int {
            return _cellWidth;
        }

        public function set cellWidth(value:int):void {
            _cellWidth = value;
        }

        public function get origin():Point {
            return _origin;
        }
    }
}
