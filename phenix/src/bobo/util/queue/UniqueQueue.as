/**
 * Created by wbguan on 2015/5/26.
 */
package bobo.util.queue {
  import com.greensock.TweenLite;

  import flash.display.DisplayObject;

  import flash.display.DisplayObjectContainer;
  import flash.events.Event;

  public class UniqueQueue extends Object {
    private var _current:DisplayObjectContainer;
    private var _root:DisplayObjectContainer;
    private var _animation:Boolean = false;

    public function UniqueQueue() {
      super();
    }

    public function init(root:DisplayObjectContainer):void {
      _root = root;
    }

    public function show(param:DisplayObjectContainer):void {
      if (_current != null && _current.parent != null) {
        remove(_current);
      }
      if (this._root != null) {
        _current = param;
        _current.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);
        if (_animation) {
          TweenLite.fromTo(_current, 0.2, {y: _current.y - 20, alpha: 0}, {y: _current.y, alpha: 1});
        }
        this._root.addChild(_current);
      }
    }

    private function onRemove(event:Event):void {
      var target:DisplayObjectContainer = event.currentTarget as DisplayObjectContainer;
      target.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
      if(target == _current){
        _current = null;
      }
    }

    public function remove(param:DisplayObjectContainer):void {
      if (param != null && param == _current) {
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
      }
    }

    private function onComplete(param:DisplayObjectContainer):void {
      if (param != null && param.parent != null) {
        param.parent.removeChild(param);
      }
    }

  }
}
