/**
 * Created by guanwenbo on 2016/8/9.
 */
package bb {
    import flash.geom.Point;

    public class LayoutBarrage extends BitmapBarrage {

        private var _lineHeight:int = 0;

        public function LayoutBarrage(w:int, h:int) {
            super(w, h);
        }



//        override protected function eleInitLocation():Point {
//            return
//        }

        public function setLineHeight(param:int):void{
            _lineHeight = param;
        }
    }
}
