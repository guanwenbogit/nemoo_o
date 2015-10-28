/**
 * Created by wbguan on 2015/3/5.
 */
package com.util.ui.unity {

  import flash.display.Sprite;
  import flash.events.MouseEvent;

  import com.util.ui.unity.LRButton;

  public class LROnOffBtn extends Sprite {
    protected var _btnOn:BaseBtn;
    protected var _btnOff:BaseBtn;
    private var _isOn:Boolean = true;
    public function LROnOffBtn(on:BaseBtn,off:BaseBtn) {
      super();
      _btnOn = on;
      _btnOff = off;
      initInstance();
      initListener();
      this.addChild(_btnOn);
    }

    private function initListener():void {
      this._btnOff.addEventListener(MouseEvent.CLICK, onOffClick);
      this._btnOn.addEventListener(MouseEvent.CLICK, onOnClick)
    }

    private function onOnClick(event:MouseEvent):void {
      this.isOn  = false;
    }

    private function onOffClick(event:MouseEvent):void {
      this.isOn  = true;
    }

    protected function initInstance():void {
    }

    public function get isOn():Boolean {
      return _isOn;
    }

    public function set isOn(value:Boolean):void {
      _isOn = value;
      if(_isOn){
        if(this.contains(this._btnOff)) {
          this.removeChild(this._btnOff);
        }
        this.addChild(this._btnOn);
      }else{
        if(this.contains(this._btnOn)) {
          this.removeChild(this._btnOn);
        }
        this.addChild(this._btnOff);
      }
    }

    public function get btnOff():BaseBtn {
      return _btnOff;
    }

    public function get btnOn():BaseBtn {
      return _btnOn;
    }
  }
}
