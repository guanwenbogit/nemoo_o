package util.ui.unity {
  import flash.display.Sprite;
  import flash.display.DisplayObject;


  /**
   * @author wbguan
   */
  public class LRRangeContainer {
    public static const UP : String = "up";
    public static const DOWN : String = "down";
    public static const LEFT : String = "left";
    public static const RIGHT : String = "right";
    private var _xy : String;
    private var _wh : String;
    private var _dir : int;
    //----------------------------------
    //  importContainer
    //----------------------------------
    protected var _importContainer:Sprite;
    public function get importContainer():Sprite {
      return _importContainer;
    }
    // ----------------------------------
    // margin
    // ----------------------------------
    protected var _margin : Number;

    public function get margin() : Number {
      return _margin;
    }

    public function set margin(value : Number) : void {
      _margin = value;
      this.range();
    }

    // ----------------------------------
    // direction
    // ----------------------------------
    protected var _direction : String;

    public function get direction() : String {
      return _direction;
    }

    public function set direction(value : String) : void {
      _direction = value;
      this.setXYWH();
      this.range();
    }

    public function LRRangeContainer(container : Sprite = null, margin : Number = 5, direction : String = LRRangeContainer.DOWN) {
      super();
      if (container != null) {
        this._importContainer = container;
      } else {
        this._importContainer = new Sprite();
      }
      this._margin = margin;
      this._direction = direction;
      this.init();
    }

    protected function init() : void {
      this.setXYWH();
    }

    protected function setXYWH() : void {
      if (this._direction == UP || this._direction == LRRangeContainer.DOWN) {
        this._xy = "y";
        this._wh = "height";
      } else {
        this._xy = "x";
        this._wh = "width";
      }
      if (this._direction == LRRangeContainer.DOWN || this._direction == LRRangeContainer.RIGHT) {
        this._dir = 1;
      } else {
        this._dir = -1;
      }
    }

    public function rangeAhead() : void {
      var length : int = this._importContainer.numChildren;
      for (var i : int = 0; i < length; i++) {
        var obj : DisplayObject = this._importContainer.getChildAt(i);
        this.appendRangeAhead(obj);
      }
    }
    
    public function center(maxLength:Number):void {
      range();
      _maxLength = maxLength;
      var len:int = this._importContainer.numChildren;
      var i:int = 0 ;
      if(this._direction == LRRangeContainer.LEFT || this._direction == LRRangeContainer.RIGHT){
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).height < _maxLength){
            _importContainer.getChildAt(i).y = int((_maxLength - _importContainer.getChildAt(i).height)/2);
          }
        }
      }else{
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).width < _maxLength){
            _importContainer.getChildAt(i).x = int((_maxLength - _importContainer.getChildAt(i).width)/2);
          }
        }
      }
    }
    
    private var _maxLength:Number = 0;
    public function rangCenter():void{
      range();
      var len:int = this._importContainer.numChildren;
      var i:int = 0 ;
      if(this._direction == LRRangeContainer.LEFT || this._direction == LRRangeContainer.RIGHT){
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).height > _maxLength){
            _maxLength = _importContainer.getChildAt(i).height;
          }
        }
        i = 0;
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).height < _maxLength){
            _importContainer.getChildAt(i).y = int((_maxLength - _importContainer.getChildAt(i).height)/2);
          }
        }
      }else{
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).width > _maxLength){
            _maxLength = _importContainer.getChildAt(i).width;
          }
        }
        i = 0;
        
        for(; i < len; i++){
          if(_importContainer.getChildAt(i).width < _maxLength){
            _importContainer.getChildAt(i).x = int((_maxLength - _importContainer.getChildAt(i).width)/2);
          }
        }
      }
    }

    public function range() : void {
      var length : int = this._importContainer.numChildren;
      for (var i : int = 0; i < length; i++) {
        var obj : DisplayObject = this._importContainer.getChildAt(i);
        this.appendRange(obj);
      }
    }

    protected function appendRangeAhead(obj : DisplayObject) : void {
      var last : int = this._importContainer.getChildIndex(obj) - 1;
      if (last >= 0) {
        var lastObj : DisplayObject = this._importContainer.getChildAt(last);
        var distance : Number = 0;
        if (this._dir > 0) {
          distance = lastObj[this._wh];
        } else {
          distance = obj[this._wh];
        }
        obj[this._xy] = lastObj[this._xy] + this._dir * (distance + this._margin);
      }else{
        obj[this._xy] = 0;
      }
    }

    protected function appendRange(obj : DisplayObject) : void {
      var last : int = this._importContainer.getChildIndex(obj) - 1;
      if (last >= 0) {
        var lastObj : DisplayObject = this._importContainer.getChildAt(last);
        var distance : Number = 0;
        if (this._dir > 0) {
          distance = lastObj[this._wh];
        } else {
          distance = obj[this._wh];
        }
        obj[this._xy] = lastObj[this._xy] + this._dir * (distance + this._margin);
      }
    }

    public function addChild(param : DisplayObject) : DisplayObject {
      var result : DisplayObject;
      result = this._importContainer.addChild(param);
      this.appendRange(param);
      return result;
    }

    public function addChildAt(param : DisplayObject, index : int) : DisplayObject {
      var result : DisplayObject;
      result = this._importContainer.addChildAt(param, index);
      this.range();
      return result;
    }

    public function removeChild(child : DisplayObject) : DisplayObject {
      var result : DisplayObject;
      result = this._importContainer.removeChild(child);
      this.range();
      return result;
    }

    public function removeChildAt(index : int) : DisplayObject {
      var result : DisplayObject;
      result = this._importContainer.removeChildAt(index);
      this.range();
      return result;
    }

    public function removeChildren(beginIndex : int = 0, endIndex : int = 2147483647) : void {
      this._importContainer.removeChildren(beginIndex, endIndex);
      this.range();
    }

    public function getView() : Sprite {
      return this._importContainer;
    }
  }
}
