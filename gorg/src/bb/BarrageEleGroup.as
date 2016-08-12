/**
 * Created by guanwenbo on 2016/8/12.
 */
package bb {


    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class BarrageEleGroup extends Object {
        private var _bitmap:Bitmap;
        private var _bitmapData:BitmapData;
        private var _eles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _speed:Point = new Point(-5,0);
        private var _bounds:Rectangle = new Rectangle();
        private var _origin:Point = new Point(Number.MAX_VALUE,Number.MAX_VALUE);
        public function BarrageEleGroup() {
            super();
            _bitmap = new Bitmap();
        }

        public function append(ele:BarrageElement):void{
            _bounds = _bounds.union(ele.bounds);
            _eles.push(ele);
        }

        public function make():void{
            if(_eles.length==1){
                _bitmapData = _eles[0].bitmapData.clone();
            }else if(_eles.length>1) {
                _bitmapData = new BitmapData(_bounds.width, _bounds.height, true, 0x11ffffff);
                var destPoint = new Point();
                for each (var ele:BarrageElement in _eles) {
                    var eleBounds:Rectangle = ele.bounds;
                    destPoint.x = eleBounds.x - _bounds.x;
                    destPoint.y = eleBounds.y - _bounds.y;
                    _bitmapData.copyPixels(ele.bitmapData, ele.bitmapData.rect, destPoint, null, null, true);
                }
            }
            _bitmap.bitmapData = _bitmapData;
            _bitmap.x = _bounds.x
            _bitmap.y = _bounds.y;
        }

        public function updateLocation():void{
            _bounds.x = _bounds.x+_speed.x;
            _bounds.y = _bounds.y+_speed.y;
            if(_bitmap){
                _bitmap.x = _bounds.x;
                _bitmap.y = _bounds.y;
            }
        }

        public function recircle():void{
            while (_eles.length>0){
                _eles.pop();
            }
            _bounds.setEmpty();
            _bitmap.bitmapData = null;
            _speed.x = 0;
            _speed.y = 0;
            _origin.x = Number.MAX_VALUE;
            _origin.y = Number.MAX_VALUE;
        }

        public function get bounds():Rectangle {
            return _bounds;
        }

        public function get bitmap():Bitmap {
            return _bitmap;
        }

        public function get speed():Point {
            return _speed;
        }


        public function get len():int {
            return _eles.length;
        }
    }
}
