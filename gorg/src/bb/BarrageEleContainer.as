/**
 * Created by guanwenbo on 2016/8/15.
 */
package bb {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import list.INote;

    public class BarrageEleContainer extends Object implements INote {
        private var _next:INote;
        private var _prev:INote;

        private var _content:String = "";
        private var _bitmapData:BitmapData;
        private var _txt:TextField;
        private var _bounds:Rectangle;
        private var _speed:Point = new Point(0, 0);
        private var _bitmap:Bitmap;

        private var _eles:Vector.<BarrageEleContainer> = new Vector.<BarrageEleContainer>();
        private var _needMade:Boolean = false;
        private var _origin:Point = new Point();
        public function BarrageEleContainer() {
            super();
            _txt = new TextField();
            var tf:TextFormat = new TextFormat(null, 16, 0xffffff);
            _txt.defaultTextFormat = tf;
            _txt.autoSize = TextFieldAutoSize.LEFT;
            _txt.multiline = false;
            _speed.x = -5;
            _speed.y = 0;
            _bitmap = new Bitmap();
            _bounds = new Rectangle(0,0,1,1);
        }

        public function append(ele:BarrageEleContainer):void{
            _bounds = _bounds.union(ele.bounds);
            _eles.push(ele);
            _needMade = true;

        }

        public function make():void{
            if(_eles.length>0&&_needMade) {
                var backup:BitmapData = _bitmapData;
                var destPoint = new Point(_origin.x - _bounds.x,_origin.y - _bounds.y);
                _bitmapData = new BitmapData(_bounds.width, _bounds.height, true, 0x00ffffff);
                _bitmapData.copyPixels(backup, backup.rect, destPoint, null, null, true);
                var ele:BarrageEleContainer = _eles.pop();
                while (ele!= null){
                    var eleBounds:Rectangle = ele.bounds;
                    destPoint.x = eleBounds.x - _bounds.x;
                    destPoint.y = eleBounds.y - _bounds.y;
                    _bitmapData.copyPixels(ele.bitmapData, ele.bitmapData.rect, destPoint, null, null, true);
                    ele.clear();
                    ele = _eles.pop();

                }
                _needMade = false;
                _bitmap.bitmapData = _bitmapData;
                _bitmap.x = _bounds.x;
                _bitmap.y = _bounds.y;
                _origin.x = _bounds.x;
                _origin.y = _bounds.y;
            }
        }

        public function drawContent():void {
            _txt.text = _content;
            var width:int = _txt.width;
            var height:int = _txt.height;
            this.updateRect();
            if(_bitmapData &&_bitmapData.width >= width && _bitmapData.height>=height){
                _bitmapData.fillRect(_bitmapData.rect,0x00ffffff);
            }else{
                _bitmapData = new BitmapData(width, height, true, 0x00ffffff);
            }
            _bitmapData.draw(_txt);
            _bounds.width = width;
            _bounds.height =height;
            _bitmap.bitmapData = _bitmapData;
            _origin.x = _bounds.x;
            _origin.y = _bounds.y;
        }

        public function updateLoaction():void{
            _bounds.x = _bounds.x + _speed.x;
            _bounds.y = _bounds.y + _speed.y;
            _origin.x = _origin.x + _speed.x;
            _origin.y = _origin.y + _speed.y;
            updateBitmap();
        }

        public function updateBitmap():void{
            _bitmap.x = _bounds.x;
            _bitmap.y = _bounds.y;
        }

        private function updateRect():void{
            var width:int = _txt.width;
            var height:int = _txt.height;
            _bounds.width = width;
            _bounds.height =height;
        }
        public function clear():void {
            _bounds.x = 0;
            _bounds.y = 0;
            _bounds.width = 1;
            _bounds.height = 1;
            _content = "";
            _needMade = false;
            _bitmap.bitmapData = null;
            _origin.x = _origin.x;
            _origin.y = _origin.y;
            if(_bitmap.parent){
                _bitmap.parent.removeChild(_bitmap);
            }
            var _ele:BarrageEleContainer = _eles.pop();
            while (_ele){
                _ele.clear();
                _ele = _eles.pop();
            }
            trace("[BarrageEleContainer->clear 123] ===========");
        }

        public function setTxtFormat(tf:TextFormat):void {
            _txt.defaultTextFormat = tf;
            _txt.setTextFormat(tf);
            this.updateRect();
        }

        public function setFilters(arr:Array):void {
            _txt.filters = arr;
            this.updateRect();
        }
        public function setContent(content:String):void{
            _content = content;
            this.updateRect();
        }

        public function updateBoundsOrigin(x:int, y:int):void {
            _bounds.x = x;
            _bounds.y = y;
            _origin.x = x;
            _origin.y = y;
        }

        public function updateSpeed(x:Number, y:int):void {
            _speed.x = x;
            _speed.y = y;
        }

        public function get next():INote {
            return _next;
        }

        public function set next(value:INote) {
            _next = value;
        }

        public function get prev():INote {
            return _prev;
        }

        public function set prev(value:INote) {
            _prev = value;
        }

        public function removeFromList():Boolean {
            _next.prev = _prev;
            _prev.next = _next;
            _next = null;
            _prev = null;
            return true;
        }

        public function get content():String {
            return _content;
        }

        public function get bitmapData():BitmapData {
            return _bitmapData;
        }

        public function get bounds():Rectangle {
            return _bounds;
        }

        public function get speed():Point {
            return _speed;
        }

        public function get bitmap():Bitmap {
            return _bitmap;
        }

    }
}
