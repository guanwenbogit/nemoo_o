/**
 * Created by wbguan on 2015/4/30.
 */
package util.ui.list {
  import com.util.ui.unity.LRRangeContainer;

  import flash.display.DisplayObject;
  import flash.display.Sprite;

  public class LRInOutList extends Sprite {
    private var _items:Vector.<LRItem> = new <LRItem>[];
    protected var _outBuffer:Vector.<LRItem> = new <LRItem>[];
    protected var _inBuffer:Vector.<LRItem> = new <LRItem>[];
    private var _clazz:Class;
    private var _range:LRRangeContainer;

    public function LRInOutList(clazz:Class,margin:int = 5,range:String = "down") {
      _clazz = clazz;
      super();
      _range = new LRRangeContainer(this,margin,range);
    }

    public function update(arr:Object,flag:Boolean=true):void{
      var i:int = 0;
      for each(var data:Object in arr){
        var item:LRItem = _items.pop();
        if(item == null){
          item = createItem();
        }
        item.setIndex(i);
        item.update(data);
        _inBuffer.push(item);
        i++;
      }
      render(flag);
    }

    private function render(flag:Boolean):void {
      renderOut(flag);
      renderIn(flag);
    }

    protected function renderIn(flag:Boolean):void {
      while(_inBuffer.length>0){
        var item:DisplayObject = _inBuffer.shift();
        if(!this.contains(item)){
          this.addChild(item);
        }
      }
      this._range.range();
    }

    protected function renderOut(flag:Boolean):void {
      var len:int = this.numChildren;
      while(this.numChildren>0){
        var item:LRItem = this.getChildAt(0) as LRItem;
        item.clear();
        item.x = item.y = 0;
        if(this.contains(item)) {
          this.removeChild(item);
          this._items.push(item);
        }
      }
    }

    protected function createItem():LRItem{
      return new _clazz;
    }

    public function clear():void {
      var item:LRItem;
      for each(item in this._items){
        item.clear();
      }
      var len:int = this.numChildren;
      for(var i:int = 0; i<len;i++) {
        item = this.getChildAt(i) as LRItem;
        item.clear();
      }
    }
  }
}
