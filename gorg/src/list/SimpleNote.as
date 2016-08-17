/**
 * Created by guanwenbo on 2016/8/15.
 */
package list {
    public class SimpleNote extends Object implements INote {
        private var _next:INote;
        private var _prev:INote;
        public function SimpleNote() {
            super();
        }

        public function get next():INote {
            return _next;
        }

        public function set next(value:INote) {
            _next = value;
        }

        public function get prev():INote {
            return _prev;
        }

        public function set prev(value:INote) {
            _prev = value;
        }

        public function removeFromList():Boolean {
            _next.prev = _prev;
            _prev.next = _next;
            _next = null;
            _prev = null;
            return true;
        }
    }
}
