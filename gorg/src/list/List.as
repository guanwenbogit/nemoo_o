/**
 * Created by guanwenbo on 2016/8/15.
 */
package list {


    public class List extends Object {
        private var _head:INote;
        private var _tail:INote;


        public function List() {
            super();
            _head = new SimpleNote();
            _tail = new SimpleNote();
            _head.next = _tail;
            _tail.prev = _head;
        }

        public function add(note:INote):void{
            note.next = _tail;
            note.prev = _tail.prev;
            _tail.prev.next = note;
            _tail.prev = note;
        }

        public function hasNote(note:INote):Boolean{
            var result:Boolean = false;
            var current:INote = _head.next;
            while (current != _tail){
                if(current == note){
                    result = true;
                    break;
                }
                current = current.next;
            }
            return result;
        }

        public function insertNoteBefore(source:INote,before:INote):Boolean{
            var result:Boolean;
            if(this.hasNote(before)){
                source.next = before;
                source.prev = before.prev;
                before.prev.next = source;
                before.prev = source;
                result = true;

            }
            return result;
        }

        public function remove(note:INote):Boolean{
            var result:Boolean;
            if(this.hasNote(note)){
                note.next.prev = note.prev;
                note.prev.next = note.next;
                note.next = note.prev = null;
                result = true;
            }
            return result;
        }

        public function get count():int{
            var result:int = 0;
            var current:INote = _head.next;
            while (current != _tail){
                result++;
                current = current.next;
            }
            return result;
        }
        public function get firstNote():INote{
            return _head?_head.next:null;
        }
        public function isTail(note:INote):Boolean{
            var result:Boolean;
            if(note != null && _tail != null){
                result = (note == _tail)
            }
            return result;
        }



    }
}
