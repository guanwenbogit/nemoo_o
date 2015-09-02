/**
 * Created by wbguan on 2015/5/25.
 */
package com.util.ui.view {

  import com.util.txt.TextUtil;

  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.Sprite;

  import com.util.ui.shape.LRRoundRectangle;

  import flash.text.TextField;

  public class PreLoadingView extends Sprite {
    private var _bg:DisplayObject;
    private var _rect:LRRoundRectangle;
    public function PreLoadingView(loading:DisplayObject,w:int,h:int) {
      super();
      _bg = loading;
      if(_bg == null){
        var txt:TextField = new TextField();
        TextUtil.setFormat(txt,0xd0ff00,12,false);
        txt.text = "loading...";
        _bg = txt;
      }
      _rect = new LRRoundRectangle(w,h,10,0x000000,0.3);
      this.addChild(_rect);
      this.addChild(this._bg);
      _bg.x = int((w-_bg.width)/2);
      _bg.y = int((h-_bg.height)/2);
    }

    public function init():void{
      if(_bg is MovieClip){
        (_bg as MovieClip).stop();
      }
      if(this._bg != null && this.contains(this._bg)) {
        this.removeChild(this._bg);
        this._bg = null;
      }
      if(this._rect != null && this.contains(this._rect)) {
        this.removeChild(this._rect);
        this._rect = null;
      }
    }
  }
}
