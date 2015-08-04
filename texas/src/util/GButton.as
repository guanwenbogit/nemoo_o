/**
 * Created by wbguan on 2015/7/31.
 */
package util {
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;

  public class GButton extends Sprite {
    private var _up:Texture;
    private var _over:Texture;
    private var _down:Texture;
    private var _dis:Texture;
    private var _img:Image;
    private var _txt:String;
    private var _enable:Boolean = true;
    private var _lock:Boolean = false;

    public function GButton(up:Texture, txt:String = "", over:Texture = null, down:Texture = null, dis:Texture = null) {
      super();
      _up = up;
      _txt = txt;
      _down = down || up;
      _dis = dis || up;
      _over = over || up;
      initInstance();
      this.addEventListener(TouchEvent.TOUCH, onTouch);
    }

    private function initInstance():void {
      _img = new Image(_up);
      this.addChild(_img);
    }

    public function setUp():void {
      _img.texture = _up;
    }

    public function setOver():void {
      _img.texture = _over;
    }

    public function setDown():void {
      _img.texture = _down;
    }

    public function setDis():void {
      _img.texture = _dis;
    }

    private function onTouch(event:TouchEvent):void {
      if (!_lock) {
        var touch:Touch = event.getTouch(this);
        if (touch != null) {
          parseTouch(touch.phase);
        } else {
          setUp();
        }
      }
    }

    private function parseTouch(action:String):void {
      switch (action) {
        case TouchPhase.BEGAN:
          setDown();
          break;
        case TouchPhase.ENDED:
          setOver();
          break;
        case TouchPhase.HOVER:
          setOver();
          break;
        case TouchPhase.MOVED:
          setOver();
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
      this.touchable = _enable;
    }

    public function get lock():Boolean {
      return _lock;
    }

    public function set lock(value:Boolean):void {
      _lock = value;
    }
  }
}
