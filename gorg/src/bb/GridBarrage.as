/**
 * Created by guanwenbo on 2016/8/12.
 */
package bb {
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;


    public class GridBarrage extends Sprite {
        private var _w:int = 0;
        private var _h:int = 0;
        private var _groups:Vector.<BarrageEleGroup> = new Vector.<BarrageEleGroup>();
        private var _recircle:Vector.<BarrageEleGroup> = new Vector.<BarrageEleGroup>();
        private var _eles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _displayEles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _stableEles:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _elesBuffer:Vector.<BarrageElement> = new Vector.<BarrageElement>();
        private var _grid:Grid;
        private var _lineHeight:int = 0;
        private var _makeMax:int = 10;

        public function GridBarrage(w:int, h:int, lineHeight:int) {
            super();
            _w = w;
            _h = h;
            _lineHeight = lineHeight;
            var cellW:int = 200;
            var cellH:int = 5*lineHeight;
            var column:int = Math.ceil(_w/cellW);
            var row:int =Math.ceil(_h/cellH);
            _grid = new Grid(row,column,cellW,cellH);
            _grid.origin.x = 0;
            _grid.origin.y = 0;
            this.addChild(_grid.bitmap);
        }
        public function addContentWithAttributes(content:String,tf:TextFormat,filters:Array):void{
            var ele = this.getEle();
            ele.setContent(content);
            ele.setTxtFormat(tf);
            ele.setFilters(filters);
            _elesBuffer.push(ele);
        }
        public function addContent(content:String):void{
            var ele = this.getEle();
            ele.setContent(content);
            _elesBuffer.push(ele);
        }
        public function render():void{
            trace("[GridBarrage->render 50] display len " + _displayEles.length)
            renderEle();
            this.makeGroup();
            renderGroup();
        }

        private function makeGroup():void{
            var len:int = _displayEles.length;
            if(len>=_makeMax) {
                trace("[GridBarrage->makeGroup 52] len : " +len);
                var rows:Object = {};
                var arr:Vector.<BarrageElement> = _displayEles.splice(0, len);

                var groups:Vector.<BarrageEleGroup> = new Vector.<BarrageEleGroup>();
                for each (var ele:BarrageElement in arr) {
                    var rowIndex:int = _grid.getIndex(ele.bounds.x,ele.bounds.y);
                    trace("[GridBarrage->makeGroup 58] rowindex : "+rowIndex);
                    if(rowIndex>=0) {
                        var row:Object = rows[rowIndex];
                        if (row == null) {
                            row = {};
                            rows[rowIndex] = row;
                        }
                        var speed:int = ele.speed.x;
                        var group:BarrageEleGroup = row[speed];
                        if (group == null) {
                            group = this.getGroup();
                            row[speed] = group;
                            this._groups.push(group);
                            groups.push(group);
                            group.speed.x = ele.speed.x;
                        }
                        group.append(ele);
                        if(ele.bitmap.parent){
                            this.removeChild(ele.bitmap);
                        }

                    }else {
                        _stableEles.push(ele);
                    }
                }
                for each (var group:BarrageEleGroup in groups) {
                    group.make();
                }

                trace("[GridBarrage->makeGroup 79] after len : " +_displayEles.length);
                trace("[GridBarrage->makeGroup 80] groups len : " + _groups.length);
            }
        }

        private function renderEle():void{
            var arr:Vector.<BarrageElement> = new Vector.<BarrageElement>();
            var ele:BarrageElement;
            for each (ele in _displayEles){
                ele.updateLoaction();
                if(!ele.bitmap.parent) {
                    this.addChild(ele.bitmap);
                }
            }
            trace("[GridBarrage->renderEle 108] stable len " + _stableEles.length);
            for each (ele in _stableEles){
                ele.updateLoaction();
                if(isOutOfEdge(ele.bounds)) {
                    if(ele.bitmap.parent) {
                        this.removeChild(ele.bitmap);
                    }
                    ele.clear();
                    _eles.push(ele);
                }else {
                    arr.push(ele);
                }
            }
            _stableEles = arr;

            ele = _elesBuffer.pop();
            if(ele){
                ele.drawContent();
                _displayEles.push(ele);
            }
        }

        private function renderGroup():void{
            var arr:Vector.<BarrageEleGroup> = new Vector.<BarrageEleGroup>();
            for each (var group:BarrageEleGroup in _groups){
                group.updateLocation();
                if(isOutOfEdge(group.bounds)) {
                    if(group.bitmap.parent) {
                        this.removeChild(group.bitmap);
                    }
                    _recircle.push(group);
                    group.recircle();
                }else {
                    if(!group.bitmap.parent) {
                        this.addChild(group.bitmap);
                    }
                    arr.push(group);
                }
            }
            _groups = arr;
        }

        private function getEle():BarrageElement{
            var result:BarrageElement = _eles.pop();
            if(!result){
                result = new BarrageElement();
            }
            result.updateBoundsOrigin(_w,int(Math.random()*_h));
            result.updateSpeed(int(-3/*-3*Math.random()*/),0);
            return result;
        }

        private function getGroup():BarrageEleGroup{
            var result:BarrageEleGroup = _recircle.pop();
            if(!result){
               result = new BarrageEleGroup();
            }
            return result;
        }

        private function isOutOfEdge(rect:Rectangle):Boolean{
            var result:Boolean;
            result = rect.right<=0;
            return result;
        }

    }
}
