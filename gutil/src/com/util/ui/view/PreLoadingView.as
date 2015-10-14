/**
 * Created by wbguan on 2015/5/25.
 */
package com.util.ui.view {


  import com.util.txt.TextUtil;
  import com.util.ui.shape.LRRoundRectangle;

  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.Sprite;


  import flash.text.TextField;

  public class PreLoadingView extends Sprite {
    private var _loading:DisplayObject;
    private var _rect:LRRoundRectangle;
    protected var _w:int = 0;
    protected var _h:int = 0;

    public function PreLoadingView(loading:DisplayObject, w:int, h:int) {
      super();
      _loading = loading;
      _w = w;
      _h = h;
      render();
    }

    private function render():void {
      if (_loading == null) {
        var txt:TextField = new TextField();
        TextUtil.setFormat(txt, 0xd0ff00, 12, false);
        txt.text = "loading...";
        _loading = txt;
      }
      _rect = new LRRoundRectangle(_w, _h, 10, 0x000000, 0.3);
      this.addChild(_rect);
      this.addChild(this._loading);
      _loading.x = int((_w - _loading.width) / 2);
      _loading.y = int((_h - _loading.height) / 2);

    }

    public function setLoadingInfo(loading:DisplayObject, w:int, h:int):void {
      setLoading(loading);
      setRect(w, h);
      render();
    }

    private function setRect(w:int, h:int):void {
      clearRect();
      _w = w;
      _h = h;
    }

    private function setLoading(loading:DisplayObject):void {
      if (_loading == null) {
        _loading = loading;
      } else {
        clearLoading();
      }
    }

    public function init():void {
      clearLoading();
      clearRect();
    }

    private function clearRect():void {
      if (this._rect != null && this.contains(this._rect)) {
        this.removeChild(this._rect);
        this._rect = null;
      }
    }

    private function clearLoading():void {
      if (_loading is MovieClip) {
        (_loading as MovieClip).stop();
      }
      if (this._loading != null && this.contains(this._loading)) {
        this.removeChild(this._loading);
        this._loading = null;
      }
    }
  }
}
