package com.util.superMarquee {
  import flash.text.TextFieldAutoSize;
  import flash.text.TextField;
  import flash.geom.Point;
  import flash.display.Sprite;

  import com.util.ui.unity.Velocity;

  /**
   * @author wbguan
   */
  public class Item extends Sprite {
    protected var _data:Object;
    private var _start:Point = new Point(0,0);
    private var _end:Point = new Point(50,0);
    private var _v:Velocity;
    private var _allDisplayed:Boolean = false;
    protected var _text:TextField;
    private var _arrive:Boolean;

    public function Item() {
      this._text = new TextField();
      this._v = new Velocity(0, 0);
    }
    
    public function init(data:Object):void {
      this._data = data;
      this._text.text = String(this._data);
      this._text.autoSize = TextFieldAutoSize.LEFT;
    }
    
    public function get start():Point {
      return _start;
    }
    
    public function get end():Point {
      return _end;
    }
    public function dispose():void {
      this.x = this.y = this._start.x = this._start.y = this._end.x = this._end.y = 0;
      
      if(this._text != null){
        this._text.text = "";
      }
      this._v.setZero();
      this._allDisplayed = this._arrive = false;
      this.alpha = 1;
      this.scaleX = this.scaleY = 1;
    }

    public function set start(start:Point):void {
      _start = start;
    }

    public function set end(end:Point):void {
      _end = end;
    }

    public function get v():Velocity {
      return _v;
    }
     
    public function set v(v:Velocity):void {
      _v = v;
    }

    public function get allDisplayed():Boolean {
      return _allDisplayed;
    }

    public function set allDisplayed(allDisplayed:Boolean):void {
      _allDisplayed = allDisplayed;
    }

    public function set arrive(arrive:Boolean):void {
      _arrive = arrive;
    }

    public function get arrive():Boolean {
      return _arrive;
    }
  }
}
