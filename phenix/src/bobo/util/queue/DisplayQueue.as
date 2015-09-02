/**
 * Created by wbguan on 2015/5/25.
 */
package bobo.util.queue {
  import com.greensock.TweenLite;

  import flash.display.DisplayObject;

  import flash.display.DisplayObjectContainer;
  import flash.events.Event;

  public class DisplayQueue extends Object {
    private var _arr:Array = [];
    private var _current:DisplayObjectContainer;
    private var _root:DisplayObjectContainer;
    private var _animation:Boolean = true;

    public function DisplayQueue() {
      super();
    }

    public function init(root:DisplayObjectContainer):void {
      this._root = root;
      check();
    }

    public function show(param:DisplayObjectContainer):void {
      if (param != null && this._arr.indexOf(param) < 0) {
        this._arr.push(param);
        check()
      }
    }

    public function remove(param:DisplayObjectContainer):void {
      if (param != null) {
        if (param == _current) {
          _current.mouseChildren = _current.mouseEnabled = false;
          if (_animation) {
            TweenLite.fromTo(_current, 0.2, {y: _current.y, alpha: 1}, {
              y: _current.y + 10,
              alpha: 0,
              onComplete: onComplete,
              onCompleteParams: [_current]
            });
          } else {
            onComplete(_current);
          }
          _current = null;
        } else {
          var index:int = this._arr.indexOf(param);
          if (index >= 0) {
            this._arr.splice(index, 0);
            onComplete(param);
          }
        }
      }
    }

    private function onComplete(param:DisplayObjectContainer):void {
      if (param != null && param.parent != null) {
        param.parent.removeChild(param);
      }
    }

    private function check():void {
      if (this._root != null) {
        if (_current == null && _arr.length > 0) {
          _current = _arr.shift() as DisplayObjectContainer;
          _current.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
          if (_animation) {
            TweenLite.fromTo(_current, 0.2, {y: _current.y - 20, alpha: 0}, {y: _current.y, alpha: 1});
          }
          this._root.addChild(_current);
        }
      }
    }

    private function onRemove(event:Event):void {
      var target:DisplayObject = event.currentTarget as DisplayObject
      target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
    }

  }
}
