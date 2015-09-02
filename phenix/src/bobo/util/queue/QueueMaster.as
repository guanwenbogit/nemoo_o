/**
 * Created by wbguan on 2015/5/25.
 */
package bobo.util.queue {

  import flash.display.DisplayObjectContainer;

  public class QueueMaster extends Object {
    private var _msgQueue:DisplayQueue;
    private var _uniqueQueue:UniqueQueue;
    public function QueueMaster() {
      super();
    }
    public function initMsg(root:DisplayObjectContainer):void{
      if(_msgQueue == null){
        _msgQueue = new DisplayQueue();
      }
      _msgQueue.init(root);
    }
    public function initUnique(root:DisplayObjectContainer):void{
      if(_uniqueQueue == null){
        _uniqueQueue = new UniqueQueue();
      }
      _uniqueQueue.init(root);
    }

    public function get msgQueue():DisplayQueue {
      return _msgQueue;
    }

    public function get uniqueQueue():UniqueQueue {
      return _uniqueQueue;
    }
  }
}
