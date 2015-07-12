/**
 * Created by wbguan on 2015/4/14.
 */
package util.ui.scrollbar {

  import com.util.ui.shape.LRRectangle;

  import flash.display.DisplayObject;

  import flash.events.MouseEvent;
  import flash.geom.Point;

  public class LRSelectedList extends LRScrollerPanel {
    private var _clazz:Class;
    private var _able:Boolean = false;
    private var _selected:LRScrollerElement;
    private var _selectedIndex:int = -1;
    private var _mousePoint:Point = new Point();
    public var elementMask:LRRectangle = new LRRectangle(206,25,0xffffff,0.3);
    private var _bg:DisplayObject;
    public function LRSelectedList(clazz:Class,w:int, h:int, margin:int = 5, max:int = 50) {
      _clazz = clazz
      super(w, h, margin, max);
      this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
      this.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
      this.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onRollOut(event:MouseEvent):void {
      if(this.contains(this.elementMask)){
        this.removeChild(this.elementMask);
      }
    }

    private function onClick(event:MouseEvent):void {
      if(this._selectedIndex>=0) {
        this.dispatchEvent(new LRSelectedListEvent(LRSelectedListEvent.CLICK_ELEMENT, this._selectedIndex));
      }
    }

    private function onMouseMove(event:MouseEvent):void {
      _mousePoint.x = this.mouseX;
      _mousePoint.y = this.mouseY;
      this._selected = getSelected();
      if(this._selected!= null) {
        this.addChild(this.elementMask);
        this.elementMask.y = _selected.oy + this.scrollerCore.getDisplayStartPoint().y;
      }
    }

    override protected function createElement():LRScrollerElement {
      var result:LRScrollerElement;
      result = new _clazz();
      return result;
    }
    private function getSelected():LRScrollerElement{
      var result:LRScrollerElement;
      var destPoint:Point = new Point();
      var index:int = 0;
      destPoint = this.scrollerCore.getDisplayStartPoint();
      for each(var element:LRScrollerElement in this._elements){
        if(element.oy + destPoint.y +element.height >= this._mousePoint.y){
          result = element;
          _selectedIndex = index;
          break;
        }
        _selectedIndex = -1;
        index++;
      }
      return result;
    }
    public function get able():Boolean {
      return _able;
    }

    public function set able(value:Boolean):void {
      _able = value;
    }
    public function get length():int{
      return this._elements.length;
    }

    public function checkElement():void {
      onMouseMove(null);
    }
  }
}
