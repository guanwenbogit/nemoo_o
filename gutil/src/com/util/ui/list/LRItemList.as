package com.util.ui.list {

  import flash.display.Sprite;

  import com.util.ui.unity.LRRangeContainer;


  /**
   * @author wbguan
   */
  public class LRItemList extends Sprite {
    protected var _items:Array = [];
    protected var _range:LRRangeContainer;
    public function LRItemList(margin:Number = 5,dir:String = "down") {
      this._range = new LRRangeContainer(this,margin,dir);
    }

    public function update(arr:Array):void{
      var i:int = 0;
      var item:LRItem;
      for each(var data:Object in arr){
        if(i<_items.length){
          item = _items[i];
        }else{
          item = createItem();
          _items.push(item);
        }
        item.setIndex(i);
        item.update(data);
        if(!this.contains(item)){
          this.addChild(item);
        }
        i++;
      }
      while(i<this._items.length){
        if(this.contains(this._items[i])){
          this.removeChild(this._items[i]);
        }
        (this._items[i] as LRItem).clear();
        i++;
      }
      this._range.range();
    }
    public function clear():void {
      for each (var item:LRItem in this._items) {
        item.clear();
      }
    }
    protected function createItem():LRItem {
      var item:LRItem = new LRItem();
      return item;
    }
    public function dispose():void{
      trace("[LRItemList/dispose]");
      while(this.numChildren > 0){
        this.removeChildAt(0);
      }
      while(this._items.length > 0){
        var item:LRItem = this._items.pop() as LRItem;
        item.dispose();
      }
    }
  }
}
