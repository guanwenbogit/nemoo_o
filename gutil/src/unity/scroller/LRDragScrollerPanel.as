package unity.scroller {
  import flash.display.Stage;

  import flash.ui.MouseCursor;
  import flash.ui.Mouse;
  import flash.display.DisplayObject;

  import flash.events.Event;
  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.geom.Point;
  import flash.events.MouseEvent;
  import flash.geom.Rectangle;


  import gshape.LRRectangle;

  import unity.LRButton;

  /**
   * @author wbguan
   */
  public class LRDragScrollerPanel extends LRScrollerPanel {
    private var _dragRect:Rectangle;
    private var _dragPoint:Point = new Point();
    private var _timer:Timer = new Timer(200,1);
    private var _dragElement:LRScrollerElement;
    private var _line:DisplayObject;
    private var _dragIndex:int = 0;
    private var _placeIndex:int = 0;
    private var _scollerBar:LRScrollerBase;
    private var _appStage:Stage;
    private var _enbleDrag:Boolean = true;
    private var _oRect:Rectangle;
    public function LRDragScrollerPanel(w:int, h:int, bar:LRButton,bg:DisplayObject,margin:int = 5, max:int = 50) {
      _dragRect = new Rectangle(0,0,1,h);
      _oRect = new Rectangle(0,0,w,h);
      _scollerBar = new LRScrollerBase(bar, bg, h);
      _scollerBar.onScolling = onScolling;
      _line = new LRRectangle(w, 2);
      super(w, h, margin, max);
      this._elementContainer.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
      this._elementContainer.addEventListener(MouseEvent.MOUSE_UP, onUp);
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
      addParent();
    }
    public function enbleDrag(value:Boolean):void{
      _enbleDrag = value;
    }
    public function checkBar():Boolean{
      var result:Boolean;
      this._scollerBar.visible = (this.getSpan() > 0);
      if(this._scollerBar.visible ){
        trace("[LRDragScrollerPanel/checkBar] " + this.getSpanScale());
        this._scollerBar.setBarScale(this.getSpanScale());
      }
      result= this._scollerBar.visible;
      return result;
    }
    public function setBarRate(rate:Number) :void{
      this._scollerBar.rate = rate;
    }
    private function onUp(event:MouseEvent):void {
      this._timer.reset();
      this._timer.stop();
    }
    public function setLine(param:DisplayObject):void {
      if(this.contains(this._line)){
        this.removeChild(this._line);
      }
      this._line = param;
    }
    public function setBarVisible(visible:Boolean):void {
      this._scollerBar.visible = visible;
    }
    public function setBarLocatin(x:int,y:int):void{
      this._scollerBar.x = x;
      this._scollerBar.y = y;
    }
    protected function addParent():void{
      this.addChild(this._scollerBar);
      this._scollerBar.x = 400;
    }
    private function onScolling():void {
      this.setRate(this._scollerBar.rate);
    }
    private function onAdded(event:Event):void {
      _appStage = stage;
      this._appStage.addEventListener(Event.MOUSE_LEAVE, onLeave);
    }
    private function onLeave(event:Event):void{
      reset();
    }
    private function onMouseUp(event:MouseEvent):void {
      if(!_enbleDrag){
        return;
      }
      if(this._dragElement != null){
        getPlace();
        this.update();
        insert();
      }
      reset();
    }
    private function reset():void {
      this._timer.stop();
      this._timer.reset();
      this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
      this.removeEventListener(Event.ENTER_FRAME, onFrame);
      this._appStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this._elementContainer.addEventListener(MouseEvent.MOUSE_UP, onUp);
      this._elementContainer.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this._dragIndex = 0;
      this._placeIndex = 0;
      Mouse.cursor = MouseCursor.ARROW;
      if(_dragElement!=null && this.contains(this._dragElement)){
        this.removeChild(this._dragElement);
        _dragElement = null;  
      }
      if(this.contains(this._line)){
        this.removeChild(this._line);
      }
    }
    private function onMouseDown(event:MouseEvent):void {
      if(this._enbleDrag){
        this._timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
        this._timer.start();
      }
    }
    private function onTimerComplete(event:TimerEvent):void {
      this._timer.stop();
      this._timer.reset();
      this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
      this._elementContainer.removeEventListener(MouseEvent.MOUSE_UP, onUp);
      this._dragPoint.x = this.mouseX;
      this._dragPoint.y = this.mouseY;
      Mouse.cursor = MouseCursor.HAND;
      this._dragElement = getDragElement();
      if(this._dragElement != null){
        this.addChild(this._dragElement);
      }
      this.addEventListener(Event.ENTER_FRAME, onFrame);
      this._elementContainer.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
      this._appStage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
    }
    private function update():void{
      var tmp:IElementInfo = this._elements[_dragIndex];
      trace("[LRDragScrollerPanel/insert] pIndex : " + this._placeIndex);
      if(_dragIndex > _placeIndex){
        this._elements.splice(_placeIndex, 0,tmp);
        this._elements.splice(_dragIndex+1,1);
        this.scrollerCore.setRect();
        this.render();
      }else if(_placeIndex - _dragIndex > 1){
        this._elements.splice(_placeIndex, 0,tmp);
        this._elements.splice(_dragIndex,1);
        this.scrollerCore.setRect();
        this.render();
      }else{
//        trace("[LRDragScrollerPanel/insert]===========itself=========");
      }
    }
    private function insert():void {
      trace("[LRDragScrollerPanel/insert] pIndex : " + this._placeIndex);
      if(_dragIndex > _placeIndex){
        this.dispatchEvent(new LRDragScrollerEvent(LRDragScrollerEvent.INSERT_EVENT,{oi:_dragIndex,di:_placeIndex}));
      }else if(_placeIndex - _dragIndex > 1){
        this.dispatchEvent(new LRDragScrollerEvent(LRDragScrollerEvent.INSERT_EVENT,{oi:_dragIndex,di:_placeIndex}));
      }else{
//        trace("[LRDragScrollerPanel/insert]===========itself=========");
      }
//      trace("[LRDragScrollerPanel/insert] length " + _elements.length);
    }
    private function getPlace():void {
      _placeIndex = 0;
      for each(var element:LRScrollerElement in this._elements){
        if(element.oy+this.scrollerCore.getDisplayStartPoint().y >= this._dragElement.y){
//          trace("[LRDragScrollerPanel/getPlace] pIndex : " + this._placeIndex);
          break;
        }
        _placeIndex++;
      }
    }
    
    private function onFrame(event:Event):void {
      if(this._dragElement != null){
        this._dragElement.y = this.mouseY;
        getPlace();
        if(_placeIndex >= this._elements.length){
          this._line.y = this._elements[this._elements.length - 1].h + this._elements[this._elements.length - 1].oy;
        }else{
          var _y:int = this._elements[_placeIndex].oy + this.scrollerCore.getDisplayStartPoint().y;
          this._line.y = _y;
        }
        if(!this.contains(_line)){
          this.addChild(this._line);
        }
        checkRage();
      }
    }
    
    private function checkRage():void {
      if(this._dragElement.y > this._dragRect.bottom){
        this._dragElement.y = this._dragRect.bottom - this._dragElement.height/2;
        bottom();
      }
      if(this._dragElement.y < this._dragRect.top){
        this._dragElement.y = this._dragRect.top ;
        this.top();
      }
    }
    private function bottom():void {
      this._scollerBar.appendBarY(this._dragElement.height);
    }
    private function top():void {
      this._scollerBar.appendBarY(-this._dragElement.height);
    }
    public function getElementUnderMouse():LRScrollerElement {
      var result:LRScrollerElement;
      var m:Point = new Point(this._elementContainer.mouseX,this._elementContainer.mouseY);
      var destPoint:Point = new Point();
      destPoint = this.scrollerCore.getDisplayStartPoint();
      for each(var element:LRScrollerElement in this._elements){
        if(element.oy + destPoint.y +element.height >= m.y){
          result = element;
          break;
        }
      }
      return result;
    }
    private function getDragElement():LRScrollerElement{
      var result:LRScrollerElement;
      var destPoint:Point = new Point();
      destPoint = this.scrollerCore.getDisplayStartPoint();
//      destPoint.y = this._dragPoint.y + destPoint.y;
//      trace("[LRDragScrollerPanel/getDragElement] dragy :　"+this._dragPoint.y);
      for each(var element:LRScrollerElement in this._elements){
//        trace("[LRDragScrollerPanel/getDragElement] ey : " + (element.oy + destPoint.y));
        if(element.oy + destPoint.y +element.height >= this._dragPoint.y){
          result = element.clone() as LRScrollerElement;
          result.y = this.mouseY;
          result.ondrag();
//          trace("[LRDragScrollerPanel/getDragElement] dIndex : " + _dragIndex);
          break;
        }
        _dragIndex++;
      }
      return result;
    }
    public function moveElements(source:int,target:int,flag:Boolean = true):void{
      if(target > this._elements.length || target <0){
        target = this._elements.length;
      }
      this._dragIndex = source;
      this._placeIndex = target;
      update();
      if(flag){
        insert();
      }
      this._dragIndex = 0;
      this._placeIndex = 0;
    }
    override public function dispose():void{
      super.dispose();
      if(this._appStage != null){
        this._appStage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        this._appStage.removeEventListener(Event.MOUSE_LEAVE, onLeave);
      }
    }
    override public function appendData(arr:Object):void {
      super.appendData(arr);
      if(this.getSpan() > 0){
        this._scollerBar.visible = true;
        this._scollerBar.setBarScale(this.getSpanScale());
      }
      trace("[LRScrollerPanel/appendData] ======== " + _elements.length);
    }
    override public function removeAll():void{
      super.removeAll();
      this.checkBar();
    }
    override public function setHeight(height:int):void{
      super.setHeight(height);
      var scale:Number = height/this._oRect.height;
      this._scollerBar.setScaleH(scale,0.2);
    }
  }
}
