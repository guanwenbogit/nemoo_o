/**
 * Created by guanwenbo on 2016/8/5.
 */
package bb {


    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;

    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.system.System;
    import flash.text.TextFormat;
    import flash.utils.Dictionary;


    public class BitmapBarrage extends Sprite {

        private var _bitmapData:BitmapData;
        private var _bitmap:Bitmap;

        private var _w:int;
        private var _h:int;
        private var _rect:Rectangle;

        protected var _displayEles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _gcCount:int = 0;
        private var _buffer:Vector.<BarrageElement>  = new Vector.<BarrageElement>();
        private var _elePool:Dictionary = new Dictionary(false);
        private var _lineHeight:int = 0;
        private var _rows:int = 0;


        public function BitmapBarrage(w:int, h:int) {
            super();
            _w = w;
            _h = h;
            initBitmapData();
        }

        public function addContentWithAttributes(content:String,tf:TextFormat,filters:Array):void{
            if(_buffer.length>80){
                return;
            }
            var ele:BarrageElement = this.getEle(content.length);
            ele.setTxtFormat(tf);
            ele.setFilters(filters);
            ele.setContent(content);
            _buffer.push(ele);
        }

        public function addContent(content:String):void {
            var ele:BarrageElement = this.getEle(content.length);
            _buffer.push(ele);
            ele.setContent(content);
        }

        public function render():void {
            var len:int = _displayEles.length;
            if(_bitmapData){
                _bitmapData.fillRect(_rect,0x00000000);
            }
            trace("[BitmapBarrage->render 54] len " + len);
            var destRect:Rectangle = new Rectangle(0,0,1,1);
            var destPoint:Point = new Point(0,0);
            var arr:Vector.<BarrageElement> = new <BarrageElement>[];
            _bitmapData.lock();

            for each (var ele:BarrageElement in _displayEles ){
                var rect:Rectangle = ele.bounds;
                if (this.isEleOutOfEdge(rect)) {
                    ele.clear();
                    _gcCount++;
                    this.collectEle(ele)
                } else {
                    rect.x = rect.x + ele.speed.x;
                    rect.y = rect.y + ele.speed.y;
                    arr.push(ele);
                    destRect.width = rect.width;
                    destRect.height = rect.height;
                    destPoint.x = rect.x;
                    destPoint.y = rect.y;
                    _bitmapData.copyPixels(ele.bitmapData, destRect, destPoint, null, null, true);
                }
            }
            _bitmapData.unlock();
            if(_gcCount>50){
                _gcCount = 0;
                System.gc()
            }

            _displayEles = arr;

            if(_buffer.length>0){
                var ele:BarrageElement = _buffer.shift();
                ele.drawContent();
                _displayEles.push(ele);
            }
        }

        public function render2():void{

            var len:int = _displayEles.length;
            var arr:Vector.<BarrageElement> = new <BarrageElement>[];
            for each (var ele:BarrageElement in _displayEles ){
                var rect:Rectangle = ele.bounds;
                if (this.isEleOutOfEdge(rect)) {
                    ele.clear();
                    _gcCount++;
                    this.collectEle(ele);
                    this.removeChild(ele.bitmap);
                } else {
                    if(!ele.bitmap.parent) {
                        this.addChild(ele.bitmap);
                    }
                    arr.push(ele);
                    rect.x = rect.x + ele.speed.x;
                    rect.y = rect.y + ele.speed.y;
                    ele.updateBitmap();
                }
            }
            trace("[BitmapBarrage->render 54] len " + len);
            if(_gcCount>50){
                _gcCount = 0;
                System.gc();
            }
            _displayEles = arr;
            if(_buffer.length>0){
                var ele:BarrageElement = _buffer.shift();
                ele.drawContent();
                _displayEles.push(ele);
            }
        }

        public function resize(w:int, h:int):void {
            _w = w;
            _h = h;
            trace("[BitmapBarrage->resize 98] len "+ this._displayEles.length);
            this.reset();
            this.initBitmapData();
        }


        protected function eleSpeed(ele:BarrageElement):int {
            return int(-3*Math.random() - 3);
        }

        protected function eleInitLocation():Point{
            return new Point(_w,int(_rows*Math.random())*_lineHeight);
        }

        private function reset():void{
            if(_bitmapData){
                _bitmapData.fillRect(_rect,0x00ffffff);
                trace("[BitmapBarrage->reset 113] reset bitmap data" );
                _bitmapData.dispose();
                _bitmapData = null;
            }
            if(_bitmap && this.contains(_bitmap)){
                trace("[BitmapBarrage->reset 113] reset bitmap" );
                this.removeChild(_bitmap);
                _bitmap.bitmapData = null;
                _bitmap = null;
            }

        }

        protected function isEleOutOfEdge(rect:Rectangle):Boolean {
            var result:Boolean;
            result = rect.right < 0  ;
            return result;
        }

        private function initBitmapData():void {
            if (_bitmap && this.contains(_bitmap)) {
                this.removeChild(_bitmap);
            }
            _bitmapData = new BitmapData(_w, _h, true, 0x00ffffff);
            _bitmap = new Bitmap(_bitmapData);
            this.addChild(_bitmap);
            this._rect = new Rectangle(0, 0, _w, _h);
        }

        private function createEle(id:int):BarrageElement {
            var result:BarrageElement;
            var arr:Vector.<BarrageElement> = _elePool[id];
            if(arr) {
                result = arr.pop();
            }
            if (result == null) {
                result = new BarrageElement();
            }
            return result;
        }

        private function getEle(id:int):BarrageElement{
            var ele:BarrageElement = this.createEle(id);
            var location:Point = this.eleInitLocation();
            ele.updateBoundsOrigin(location.x,location.y);
            var speed:int = this.eleSpeed(ele);
            ele.updateSpeed(speed,0);
            return ele;
        }

        private function collectEle(ele:BarrageElement):void{
            var arr:Vector.<BarrageElement> = _elePool[ele.len];
            if(!arr){
                arr = new Vector.<BarrageElement>();
                _elePool[ele.len] = arr;
            }
            arr.push(ele);
        }

        public function get lineHeight():int {
            return _lineHeight;
        }

        public function set lineHeight(value:int):void {
            _lineHeight = value;
            _rows = Math.ceil(_h/_lineHeight);
        }
    }

}
