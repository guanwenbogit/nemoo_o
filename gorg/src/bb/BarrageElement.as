/**
 * Created by guanwenbo on 2016/8/5.
 */
package bb {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    public class BarrageElement extends Object {

        private var _content:String = "";
        private var _bitmapData:BitmapData;
        private var _txt:TextField;
        private var _rect:Rectangle;
        private var _speed:Point = new Point(0, 0);
        private var _bitmap:Bitmap;
        private var _len:int = 0;

        public function BarrageElement() {
            super();
            _txt = new TextField();
            var tf:TextFormat = new TextFormat(null, 16, 0xffffff);
            _txt.defaultTextFormat = tf;
            _txt.autoSize = TextFieldAutoSize.LEFT;
            _txt.multiline = false;
            _speed.x = -5;
            _speed.y = 0;
            _bitmap = new Bitmap();
            _rect = new Rectangle(0,0,1,1);
        }

        public function drawContent():void {
            _txt.text = _content;
            var width:int = _txt.width;
            var height:int = _txt.height;
            if(_bitmapData &&_bitmapData.width >= width && _bitmapData.height>=height){

                _bitmapData.fillRect(_bitmapData.rect,0x00ffffff);
            }else{
                _bitmapData = new BitmapData(width, height, true, 0x00ffffff);
            }
            _bitmapData.draw(_txt);
            _rect.width = width;
            _rect.height =height;
            _bitmap.bitmapData = _bitmapData;
            _speed.x = -(2.1 + _rect.width/20*0.1);
        }

        public function updateSpeed(x:Number, y:int):void {
            _speed.x = x;
            _speed.y = y;
        }

        public function updateLocation(x:int, y:int):void {
            _rect.x = x;
            _rect.y = y;
        }

        public function updateBitmap():void{
            _bitmap.x = _rect.x;
            _bitmap.y = _rect.y;
        }

        public function get rect():Rectangle {
            return _rect;
        }

        public function clear():void {
            _rect.x = 0;
            _rect.y = 0;
            _rect.width = 1;
            _rect.height = 1;
            _content = "";
//            this.resetBitmap();
        }

        public function get speed():Point {
            return _speed;
        }

        public function get bitmapData():BitmapData {
            return _bitmapData;
        }


        public function get bitmap():Bitmap {
            return _bitmap;
        }

        public function setTxtFormat(tf:TextFormat):void {
            _txt.defaultTextFormat = tf;
            _txt.setTextFormat(tf);
        }

        public function setFilters(arr:Array):void {
            _txt.filters = arr;
        }
        public function setContent(content:String):void{
            _content = content;
            if(_len == 0) {
                _len = _content.length;
            }
        }

        private function resetBitmap():void {
            if (_bitmap) {
                _bitmap.bitmapData = null;
            }

            if (_bitmapData) {
                _bitmapData.dispose();
                _bitmapData = null;
            }
        }

        public function get len():int {
            return _len;
        }
    }
}
