package util.superMarquee {

  import flash.events.TimerEvent;
  import flash.utils.Timer;
  import flash.events.Event;
  import flash.display.Sprite;

  import util.ui.shape.LRRectangle;

  import util.ui.unity.Velocity;

  /**
   * @author wbguan
   */
  public class SuperMarquee extends Sprite {
    
    private var _data:Array;
    private var _displays:Vector.<Item> = new Vector.<Item>();
    private var _items:Vector.<Item> = new Vector.<Item>();
    private var _max:int = 6;
    private var _displayWidth:int;
    private var _displayHeight:int;
    private var _mask:LRRectangle;
    private var _render:SuperMarqueeRender;
    protected var _v:Velocity;
    private var _margin:int = 2;
    private var _arriveTimer:Timer = new Timer(5000,1);
    public function SuperMarquee(width:int,height:int) {
      this._displayWidth = width;
      this._displayHeight = height;
      this._data = new Array();
      this._mask = new LRRectangle(this._displayWidth, this._displayHeight);
      this.mask = this._mask;
      this.addChild(_mask);
      this.initInstance();
      this.initListener();
    }
    private function initListener():void{
      this._arriveTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
    }
    protected function initInstance():void {
      this._render = new SuperMarqueeRender();
      this._v = new Velocity(-1, 0);
      this._render.setDisplays(this._displays);
    }
    public function setWH(w:int,h:int):void {
      this._displayHeight = h;
      this._displayWidth = w;
      this._mask.width = w;
      this._mask.height = h;
      for each(var item:Item in _displays){
        if((item.x + item.width <= this._displayWidth)){
          item.allDisplayed = true;
        }else{
          item.allDisplayed = false;
        }
      }
    }
    public function start():void {
      this.resume();
    }
    public function stop():void {
      this.pause();
    }
    public function appendItem(data:Object):void{
      _data.push(data);
    }
    public function appendItems(args:Array):void{
      for each(var data:Object in args){
        _data.push(data);
      }
    }
    protected function pause():void{
      if(this.hasEventListener(Event.ENTER_FRAME)){
        this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
      }
    }
    protected function resume():void{
      if(!this.hasEventListener(Event.ENTER_FRAME)){
        this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
      }
    }
    protected function render():void{
      this._render.render();
    }
    private function checkDisplays():void{
      while(_displays.length < _max && this._data.length >0){
        var item:Item = nextItem();
        if(item != null){
          item.v.x = this._v.x;
          item.v.y = this._v.y;
          setItemLocation(item);
          this._displays.push(item);
          this.addChild(item);
        }
      }
    }
    private function updateDisplayEndLocation():void{
      var i:int = 0;
      for each(var item:Item in this._displays){
        if(i==0){
          item.end.x = 0;
        }else{
          var prev:Item = _displays[i-1];
          item.end.x = prev.end.x + prev.width +this._margin;
        }
        item.v.x = this._v.x;
        item.v.y = this._v.y;
        item.arrive = false;
        i++;
      }
    }
    private function setItemLocation(item:Item):void{
      var len:int = _displays.length;
      if(this._v.x !=0){
        this.setXLocation(item);
      }
      if(this._v.y != 0){
        this.setYLocation(item);
      }
      item.x = item.start.x;
      item.y = item.start.y;
    }

    private function setYLocation(item:Item):void {
      var len:int = _displays.length;
      if(this._v.y > 0){
        if(len < 1){
          item.start.y = - item.height;
          item.end.y = this._displayHeight-item.height;
        }else{
          var last:Item = _displays[len - 1];
          if(last.allDisplayed){
            item.start.y = - item.height - _margin;
          }else{
            item.start.y = last.y - item.height - _margin;
          }
          item.end.y = last.end.y - item.height - _margin;
        }
      }else if(this._v.y <0){
        if(len < 1){
          item.start.y = this._displayHeight;
          item.end.y = 0;
        }else{
          var last:Item = _displays[len - 1];
          if(last.allDisplayed){
            item.start.y =  last.height + _margin;
          }else{
            item.start.y = last.y + last.height + _margin;
          }
          item.end.y = last.end.y + last.height + _margin;
        }
      }
    }
    private function setXLocation(item:Item):void{
      var len:int = _displays.length;
      if(this._v.x <0){
        if(len < 1){
          item.start.x = this._displayWidth;
          item.end.x = 0;
        }else{
          var last:Item = _displays[len - 1];
          if(last.allDisplayed){
            item.start.x = this._displayWidth + this._margin;
          }else{
            item.start.x = last.x+ last.width + this._margin;
          }
          item.end.x = last.end.x + last.width + this._margin;
        }
      }else if(this._v.x > 0){
        if(len < 1){
          item.start.x = -item.width;
          item.end.x = this._displayWidth - item.width;
        }else{
          var last:Item = _displays[len - 1];
          if(last.allDisplayed){
            item.start.x = -item.width - this._margin;
          }else{
            item.start.x = last.x- item.width - this._margin;
          }
          item.end.x = last.end.x - item.width - this._margin;
        }
      }
    }

    private function checkArrive():void{
      var i:int = 0;
      for each(var item:Item in _displays){
        if(!item.allDisplayed && (item.x + item.width <= this._displayWidth)){
          item.allDisplayed = true;
        }
        if(item.x <= item.end.x){
          item.x = item.end.x;
          item.v.setZero();
          if(i == 0 && !item.arrive){
            arrive();
          }
          item.arrive = true;
        }
        i++;
      }
    }
    private function arrive():void {
      this._arriveTimer.start();
    }
    private function onEnterFrame(event:Event):void {
      checkDisplays();
      this.render();
      checkArrive();
    }
    private function onTimerComplete(event:TimerEvent):void{
      abortFirst();
      _arriveTimer.stop();
    }
    private function nextItem():Item{
      var result:Item;
      if(_data.length > 0){
        var source:Object = _data.shift();
        result = getItem();
        result.init(source);
      } else {
      }
      return result;
    }
    private function getItem():Item {
      var result:Item;
      if(_items.length > 0 ){
        result = _items.pop();
      }else{
        result = creatItem(); 
      }
      return result;
    }
    protected function creatItem():Item{
      return new Item();
    }
    private function abortFirst():Item{
      var item:Item = this._displays[0];
      onAborted(item);
//      TweenMax.to(item, 1, {alpha:0,x:item.x+3,y:item.y+3,scaleX:0.9,scaleY:0.9,onComplete:onAborted,onCompleteParams:[item]});
      return item;
    }
    private function onAborted(item:Item):void {
      if(item.parent != null){
        item.parent.removeChild(item);
        item.dispose();
        this._displays.shift();
        this._items.push(item);
      }
      if(this._data.length == 0 && this._displays.length == 0){
        this.dispatchEvent(new SuperMarqueeEvent(SuperMarqueeEvent.EMPTY_EVENT));
      }
      updateDisplayEndLocation();
    }

  }
}
