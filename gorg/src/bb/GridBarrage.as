/**
 * Created by guanwenbo on 2016/8/12.
 */
package bb {
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.text.TextFormat;

    import list.INote;


    import list.List;


    public class GridBarrage extends Sprite {
        private var _w:int = 0;
        private var _h:int = 0;
        private var _displayEles:List = new List();
        private var _stableEles:List = new List();

        private var _eles:Vector.<BarrageEleContainer> = new Vector.<BarrageEleContainer>();

        private var _elesBuffer:Vector.<BarrageEleContainer> = new Vector.<BarrageEleContainer>();
        private var _grid:Grid;
        private var _lineHeight:int = 0;
        private var _makeMax:int = 30;

        public function GridBarrage(w:int, h:int, lineHeight:int) {
            super();
            _w = w;
            _h = h;
            _lineHeight = lineHeight;
            var cellW:int = w / 4;
            var cellH:int = 3 * lineHeight;
            var column:int = Math.ceil(_w / cellW);
            var row:int = Math.ceil(_h / cellH);
            _grid = new Grid(row, 2, cellW, cellH);
            _grid.origin.x = w - cellW*2 + 5;
            _grid.origin.y = 0;
//            this.addChild(_grid.bitmap);
        }

        public function addContentWithAttributes(content:String, tf:TextFormat, filters:Array):void {
            var ele = this.getContainer();
            ele.setContent(content);
            ele.setTxtFormat(tf);
            ele.setFilters(filters);
            _elesBuffer.push(ele);
        }

        public function addContent(content:String):void {
            var ele = this.getContainer();
            ele.setContent(content);
            _elesBuffer.push(ele);
            trace("[GridBarrage->addContent 55] add ");
        }

        public function render():void {
            this.makeContainer();
            this.renderContainer();
        }

        private function makeContainer():void {
            var len:int = _displayEles.count;
            if (len >= _makeMax) {
                var rows:Object = {};
                var ele:BarrageEleContainer = _displayEles.firstNote as BarrageEleContainer;
                while (ele && !_displayEles.isTail(ele)) {
                    var rowIndex:int = _grid.getIndex(ele.bounds.x, ele.bounds.y);
                    var tmp:BarrageEleContainer = ele.next as BarrageEleContainer;
                    if (rowIndex >= 0) {
                        var row:Object = rows[rowIndex];
                        if (row == null) {
                            row = {};
                            rows[rowIndex] = row;
                        }
                        var speed:int = ele.speed.x;
                        var container:BarrageEleContainer = row[speed];
                        if (container == null) {
                            row[speed] = ele;
                        } else {
                            container.append(ele);
                            ele.removeFromList();
                        }
                    }
                    ele = tmp;
                }
                ele = _displayEles.firstNote as BarrageEleContainer;
                while (ele && !_displayEles.isTail(ele)) {
                    ele.make();
                    ele = ele.next as BarrageEleContainer;
                }
            }
        }

        private function renderContainer() {
            var ele:BarrageEleContainer
            ele = _stableEles.firstNote as BarrageEleContainer;
            while (ele && !_stableEles.isTail(ele)) {
                var tmp:INote = ele.next;
                ele.updateLoaction();
                if (isOutOfEdge(ele.bounds)) {
                    if (ele.bitmap.parent) {
                        this.removeChild(ele.bitmap);
                    }
                    ele.removeFromList();
                    ele.clear();
                    _eles.push(ele);
                }
                ele = tmp as BarrageEleContainer;
            }

            ele = _displayEles.firstNote as BarrageEleContainer;
            while (ele && !_displayEles.isTail(ele)) {
                var tmp:INote = ele.next;
                ele.updateLoaction();
                if (!ele.bitmap.parent) {
                    this.addChild(ele.bitmap);
                }
                var rowIndex:int = _grid.getIndex(ele.bounds.x, ele.bounds.y);
                trace("column rowindex : " + rowIndex);
                if(rowIndex<0) {
                    trace("[GridBarrage->makeContainer 88] stable ");
                    ele.removeFromList();
                    _stableEles.add(ele);
                }
                ele = tmp as BarrageEleContainer;
            }
            ele = _elesBuffer.pop();
            if (ele) {
                ele.drawContent();
                _displayEles.add(ele);
            }
        }


        private function getContainer():BarrageEleContainer {
            var result:BarrageEleContainer = _eles.pop();
            if (!result) {
                result = new BarrageEleContainer();
            }
            result.updateBoundsOrigin(_w, int(Math.random() * _h));
            result.updateSpeed(int(-3 - 3 * Math.random()), 0);
            return result;
        }

        private function isOutOfEdge(rect:Rectangle):Boolean {
            var result:Boolean;
            result = rect.right <= 0;
            return result;
        }

    }
}
