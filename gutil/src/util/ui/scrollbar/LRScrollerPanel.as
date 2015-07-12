package util.ui.scrollbar {
  import flash.display.Shape;
  import flash.display.Sprite;
  import flash.geom.Point;

  /**
   * @author wbguan
   */
  public class LRScrollerPanel extends Sprite {
    private var _max:int = 0;
    protected var _elements:Vector.<IElementInfo> ;
    private var _scrollerCore:LRScrollerPanelCore;
    private var _mask:Shape = new Shape();
    protected var _elementContainer:Sprite;
    protected var _index:int = 0;
    public function LRScrollerPanel(w:int, h:int, margin:int = 5,max:int = 50) {
      _max = max;
      this._elementContainer = new Sprite();
      _scrollerCore = new LRScrollerPanelCore(w, h,margin);
      this._elements = new Vector.<IElementInfo>();
      _scrollerCore.attachElements(_elements);
      this.addChild(this._elementContainer);
      initMask(w, h);
    }
    public function setHeight(h:int):void{
      this._mask.height = h;
      this._scrollerCore.setHeight(h);
    }
    private function initMask(w:int, h:int):void {
      _mask = new Shape();
      _mask.graphics.beginFill(0xffffff, 1.0);
      _mask.graphics.drawRect(0, 0, w, h);
      _mask.graphics.endFill();
      _mask.alpha = 0.9;
      this.addChild(this._mask);
      this._elementContainer.mask = this._mask;
    }
    
    public function appendData(arr:Object):void {
      for each (var data:Object in arr) {
        var element:LRScrollerElement = getElement();
        element.init();
        element.setData(data);
      }
      this._scrollerCore.setRect();
      trace("[LRScrollerPanel/appendData] ======== " + _elements.length);
    }
    public function setRect():void {
      this._scrollerCore.setRect();
    }
    public function getSpan():int {
      return this._scrollerCore.getSpan();
    }

    public function getSpanScale():Number {
      return this._scrollerCore.getSpanScale();
    }

    public function setRate(rate:Number):void {
      this._scrollerCore.setRate(rate);
      render();
    }

    public function render():void {
      var excepts:Vector.<IElementInfo> = new Vector.<IElementInfo>();
      var infos:Vector.<IElementInfo> = this._scrollerCore.getDisplayInfos(excepts);
      for each (var e:LRScrollerElement in excepts) {
        e.visible = false;
        if (this._elementContainer.contains(e)) {
          this._elementContainer.removeChild(e);
        }
      }
      for each (var info:LRScrollerElement in infos) {
        info.y = info.oy + this._scrollerCore.getDisplayStartPoint().y;
        if (!this._elementContainer.contains(info)) {
          this._elementContainer.addChild(info);
        }
        info.visible = true;
      }
    }

    private function getElement():LRScrollerElement {
      var result:LRScrollerElement;
      if (result == null) {
        var len:int = _elements.length;
        if (len< this._max) {
          result = createElement();
          _elements.push(result);
        } else {
          result = _elements.shift() as LRScrollerElement;
          result.clear();
          if (this._elementContainer.contains(result)) {
            this._elementContainer.removeChild(result);
          }
          _elements.push(result);
        }
      }
      return result;
    }
    public function refresh(arr:Object):void {
      while(_elements.length > 0){
        var tmp:LRScrollerElement = _elements.pop() as LRScrollerElement;
        tmp.clear();
        if (this._elementContainer.contains(tmp)) {
            this._elementContainer.removeChild(tmp);
        }
      }
      this.appendData(arr);
      this.render();
    }
    public function removeElementByIndex(index:int):void{
      if(index >=0 && index < this._elements.length){
        var tmp:LRScrollerElement = _elements[index] as LRScrollerElement;
        _elements.splice(index, 1);
        tmp.clear();
        if (this._elementContainer.contains(tmp)) {
          this._elementContainer.removeChild(tmp);
        }
        this._scrollerCore.setRect();
      }
    }
    public function moveStep(next:Boolean):void{
      var ele1:IElementInfo;
      var span:int = 0;
      var ele2:IElementInfo;
      if(next){
        _index = getDisplayLast();
        if(_index<_elements.length-1){
          ele1 = this._elements[_index];
          ele2 = this._elements[_index+1];
          span = this._mask.height - ((ele1.oy+this._scrollerCore.getDisplayStartPoint().y + ele1.h)+ele2.h);
        }
      }else{
        _index = getDisplayFirst();
        if(_index>=0){
          ele2 = this._elements[_index];
          span = -(ele2.oy+this._scrollerCore.getDisplayStartPoint().y);
        }
      }
      this._scrollerCore.move(span);
      render();
    }
    private function getDisplayLast():int{
      return this.scrollerCore.getDisplayLast();
    }
    private function getDisplayFirst():int{
      return this.scrollerCore.getDisplayFirst();
    }
    public function removeAll():void{
      while(_elements.length > 0){
        var tmp:LRScrollerElement = _elements.pop() as LRScrollerElement;
        tmp.clear();
        if (this._elementContainer.contains(tmp)) {
            this._elementContainer.removeChild(tmp);
        }
      }
      _scrollerCore.setRect();
      this.render();
    }
    
    protected function createElement():LRScrollerElement {
      var result:LRScrollerElement;
      result = new LRScrollerElement();
      return result;
    }
    public function getRate():Number {
      return this._scrollerCore.getRate();
    }
    public function isTop():Boolean{
      return this._scrollerCore.getDisplayStartPoint().y == 0;
    }
    public function isEnd():Boolean{
      var span:int = this._scrollerCore.getSpan();
      var result:Boolean = false;
      if(span>0){
        result = this._scrollerCore.getDisplayStartPoint().y == -span;
      }else{
        result = true;
      }
      return result;
    }
    public function dispose():void {
      while(this.numChildren > 0){
        this.removeChildAt(0);
      }
      _scrollerCore.dispose();
    }

    public function get scrollerCore():LRScrollerPanelCore {
      return _scrollerCore;
    }
  }
}
