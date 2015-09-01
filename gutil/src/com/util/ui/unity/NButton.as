/**
 * Created by wbguan on 2015/8/31.
 */
package com.util.ui.unity {
  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.events.MouseEvent;

  public class NButton extends BaseBtn {
    private var _img:Bitmap;
    private var _up:BitmapData;
    private var _over:BitmapData;
    private var _down:BitmapData;
    private var _dis:BitmapData;
    private var _txt:String;
    private var _enable:Boolean = true;
    private var _lock:Boolean = false;

    public function NButton(up:BitmapData, txt:String = "", over:BitmapData = null, down:BitmapData = null, dis:BitmapData = null) {
      _up = up;
      _txt = txt;
      _over = over || up;
      _down = down || _over;
      _dis = dis || _down;

      initInstance();
      this.addEventListener(MouseEvent.MOUSE_DOWN, onTouch);
      this.addEventListener(MouseEvent.ROLL_OVER, onTouch);
      this.addEventListener(MouseEvent.ROLL_OUT, onTouch);
      this.addEventListener(MouseEvent.MOUSE_UP, onTouch);
      this.buttonMode = true;
    }

    private function initInstance():void {
      _img = new Bitmap(_up);
      this.addChild(_img);
    }

    override public function setMouseDown():void {
      setDown();
    }

    override public function setMouseOver():void {
      setOver();
    }

    override public function setMouseUp():void {
      setUp();
    }


    override public function lockState():void {
      super.lockState();
      this._lock = true;
    }


    override public function unlockState():void {
      super.unlockState();
      this._lock = false;
    }

    public function setUp():void {
      _img.bitmapData = _up;
    }

    public function setOver():void {
      _img.bitmapData = _over;
    }

    public function setDown():void {
      _img.bitmapData = _down;
    }

    public function setDis():void {
      _img.bitmapData = _dis;
    }

    private function onTouch(event:MouseEvent):void {
      if (!_lock) {
        if (event != null) {
          parseTouch(event.type);
        } else {
          setUp();
        }
      }
    }

    private function parseTouch(action:String):void {
      switch (action) {
        case MouseEvent.MOUSE_DOWN:
          setDown();
          break;
        case MouseEvent.ROLL_OVER:
          setOver();
          break;
        case MouseEvent.ROLL_OUT:
          setUp();
          break;
        case MouseEvent.MOUSE_UP:
          setUp();
          break;
      }
    }

    public function get enable():Boolean {
      return _enable;
    }

    public function set enable(value:Boolean):void {
      _enable = value;
      if (_enable) {
        setUp();
      } else {
        setDis();
      }
      this.mouseEnabled = _enable;
    }

    public function get lock():Boolean {
      return _lock;
    }

    public function set lock(value:Boolean):void {
      _lock = value;
    }
  }
}
