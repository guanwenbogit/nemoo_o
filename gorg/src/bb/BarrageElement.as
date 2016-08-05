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
    import flash.utils.ByteArray;
    import flash.utils.getTimer;

    public class BarrageElement extends Object {

        private var _content:String = "";
        private var _bitmapData:BitmapData;
        private var _txt:TextField;
        private var _rect:Rectangle;
        private var _speed:Point = new Point(0,0);
        private var _bitmap:Bitmap;
        private var _byteArr:ByteArray;

        public function BarrageElement() {
            super();
            _txt = new TextField();
            var tf:TextFormat = new TextFormat(null,16,0xffffff);
            _txt.defaultTextFormat = tf;
            _txt.autoSize = TextFieldAutoSize.LEFT;
            _txt.multiline = false;
            _speed.x = -5;
            _speed.y = 0;
        }

        public function updateContent(content:String):void{
            _content = content;
            _txt.text = content;
            _bitmapData = new BitmapData(_txt.width,_txt.height,true,0x00ffffff);
            var last:int = getTimer();
            _bitmapData.draw(_txt);
            trace("[BarrageElement->updateContent 33]"+(getTimer()-last));
            _rect = new Rectangle(0,0,_txt.width,_txt.height);
            _bitmap = new Bitmap(_bitmapData);
            _byteArr = _bitmapData.getPixels(new Rectangle(0,0,_bitmapData.width,_bitmapData.height));
            _byteArr.position = 0;
        }

        public function updateSpeed(x:int,y:int):void{
            _speed.x = x;
            _speed.y = y;
        }

        public function updateLocation(x:int,y:int):void{
            if(_rect) {
                _rect.x = x;
                _rect.y = y;
            }
        }

        public function get rect():Rectangle{
            return _rect;
        }

        public function clear():void{

        }

        public function get speed():Point{
            return _speed;
        }

        public function get bitmapData():BitmapData{
            return _bitmapData;
        }


        public function get bitmap():Bitmap{
            return _bitmap;
        }


        public function get byteArr():ByteArray {
            return _byteArr;
        }
    }
}
