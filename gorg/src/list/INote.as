/**
 * Created by guanwenbo on 2016/8/15.
 */
package list {
    public interface INote {
        function get next():INote;
        function set next(value:INote);
        function get prev():INote;
        function set prev(value:INote);
        function removeFromList():Boolean;
    }
}
