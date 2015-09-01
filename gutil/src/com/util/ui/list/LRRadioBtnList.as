package com.util.ui.list {

  import flash.display.DisplayObject;
  import flash.events.MouseEvent;


  import flash.display.Sprite;

  import com.util.ui.unity.BaseBtn;

  import com.util.ui.unity.LRButton;


  /**
   * @author wbguan
   */
  public class LRRadioBtnList extends Sprite {
    private var _current:BaseBtn;
    private var _btns:Vector.<BaseBtn> = new Vector.<BaseBtn>();
    private var _index:int = 0;
    public function LRRadioBtnList() {
    }

    private function addBtnEvent(btn:BaseBtn):void {
      btn.addEventListener(MouseEvent.CLICK, onClick);
    }

    private function onClick(event:MouseEvent):void {
      trace("[LRRadioBtnList/onClick]");
      var target:DisplayObject = event.target as DisplayObject;
      if (target != null) {
        var i:int = 0;
        for each(var btn:BaseBtn in this._btns){
          if(btn.contains(target) || btn == target){
            setCurrent(i);
            break; 
          }
          i++;
        }
      }
    }
    private function addToParent(btn:BaseBtn):void{
      this.addChild(btn);
    }
    public function getBtnByIndex(index:int):BaseBtn{
      var result:BaseBtn;
      if(index< this._btns.length&&index>=0){
        result = this._btns[index];
      }
      return result;
    }
    public function appendBtn(btn:BaseBtn):void {
      this._btns.push(btn);
      addBtnEvent(btn);
      addToParent(btn);
    }
    public function removeBtn(btn:BaseBtn):void{
      var i:int = this._btns.indexOf(btn);
      if(i>=0){
        this._btns.splice(i, 1);
        if(this.contains(btn)){
          this.removeChild(btn);
        }
      }
    }
    public function appendBtns(...args):void {
      for each (var btn:BaseBtn in args) {
        this._btns.push(btn);
        addBtnEvent(btn);
        addToParent(btn);
      }
    }

    public function setCurrent(index:int):void {
      if (index >= 0 && index < this._btns.length) {
        var tmp:BaseBtn = this._btns[index];
        if (_current != tmp || _current == null) {
          if (this._current != null) {
            this._current.unlockState();
            this._current.setMouseUp();
          }
          this._index = index;
          this._current = tmp;
          this._current.setMouseDown();
          this._current.lockState();
          this.dispatchEvent(new LRRadioBtnEvent(LRRadioBtnEvent.CHANGE_EVENT, index));
        }else{
          selectCurrent();
        }
      }else{
        if (this._current != null) {
          this._current.unlockState();
          this._current.setMouseUp();
        }
        this._current = null;
      }
    }

    protected function selectCurrent():void {
      this.dispatchEvent(new LRRadioBtnEvent(LRRadioBtnEvent.SELECT_CURRENT_EVENT, this._index));
    }
    public function clear():void {
      while(this._btns.length>0){
        var btn:BaseBtn = this._btns.pop();
        btn.unlockState();
        if(this.contains(btn)){
          this.removeChild(btn);
        }
      }
      if(_current != null){
        this._current.unlockState();
        this._current.setMouseUp();
      }
      _current = null;
    }
    public function get btns():Vector.<BaseBtn> {
      return _btns;
    }


    public function get index():int {
      return _index;
    }
  }
}
