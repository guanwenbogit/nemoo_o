/**
 * Created by guanwenbo on 2016/8/5.
 */
package bb {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.ColorTransform;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.net.drm.VoucherAccessInfo;

    public class BitmapBarrage extends Sprite {

        private var _bitmapData:BitmapData;
        private var _bitmap:Bitmap;

        private var _w:int;
        private var _h:int;
        private var _rect:Rectangle;
        private var _eles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _displayEles:Vector.<BarrageElement> = new Vector.<BarrageElement>();

        public function BitmapBarrage(w:int, h:int) {
            super();
            _w = w;
            _h = h;
            initBitmapData();
        }

        public function addContent(content:String):void {
            var ele:BarrageElement = this.createEle();
            ele.updateContent(content);
            _displayEles.push(ele);
            ele.updateLocation(_rect.width-5,101*Math.random() );
        }

        public function render():void {
            var len:int = _displayEles.length;
            _bitmapData.fillRect(_rect,0x00ffffff);
            for (var i:int = len - 1; i >= 0; i--) {
                var ele:BarrageElement = _displayEles[i];
                if (this.isEleOutOfEdge(ele.rect)) {
                    _displayEles.pop();
                    ele.clear();
                    _eles.push(ele);
                } else {
                    ele.rect.x = ele.rect.x + ele.speed.x;
                    ele.rect.y = ele.rect.y + ele.speed.y;
//                    _bitmapData.setPixels(ele.rect,ele.byteArr);
//                    _bitmapData.merge(ele.bitmapData,new Rectangle(0, 0, ele.rect.width, ele.rect.height),new Point(ele.rect.x, ele.rect.y),0,0,0,1);

                    _bitmapData.copyPixels(ele.bitmapData, new Rectangle(0, 0, ele.rect.width, ele.rect.height), new Point(ele.rect.x, ele.rect.y),null,null,true);
                }
            }
        }

        public function render2():void{
            var len:int = _displayEles.length;
            _bitmapData.fillRect(_rect,0x00ffffff);
            for (var i:int = len - 1; i >= 0; i--) {
                var ele:BarrageElement = _displayEles[i];
                if (this.isEleOutOfEdge(ele.rect)) {
                    _displayEles.pop();
                    ele.clear();
                    _eles.push(ele);
                    if(this.contains(ele.bitmap)){
                        this.removeChild(ele.bitmap);
                    }
                } else {
                    if(!this.contains(ele.bitmap)){
                        this.addChild(ele.bitmap);
                    }
                    ele.rect.x = ele.rect.x + ele.speed.x;
                    ele.rect.y = ele.rect.y + ele.speed.y;
                    ele.bitmap.x = ele.rect.x;
                    ele.bitmap.y = ele.rect.y;
                }
            }
        }

        public function resize(w:int, h:int):void {
            _w = w;
            _h = h;
        }

        private function isEleOutOfEdge(rect:Rectangle):Boolean {
            var result:Boolean;
            result = !_rect.intersects(rect);
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

        private function createEle():BarrageElement {
            var result:BarrageElement;
            result = _eles.pop();
            if (result == null) {
                result = new BarrageElement();
            }
            return result;
        }
    }

}
