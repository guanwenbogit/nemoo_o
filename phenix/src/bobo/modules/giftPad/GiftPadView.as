/**
 * Created by wbguan on 2015/9/22.
 */
package bobo.modules.giftPad {
  import bobo.constants.UINames;

  import com.util.reflect.ReflectionUtil;
  import com.util.ui.view.PreLoadingView;

  import flash.display.DisplayObject;
  import flash.display.MovieClip;
  import flash.display.Sprite;
  import flash.events.Event;

  public class GiftPadView extends PreLoadingView {
    private var _form:Sprite;
    private var giftKing_mc:Sprite;
    private var comboKing_mc:Sprite;
    private var glow1:MovieClip;
    private var glow2:MovieClip;

    public function GiftPadView(loading:DisplayObject, w:int, h:int) {
      super(loading, w, h);
    }

    override public function init():void {
      super.init();
      _form = ReflectionUtil.getDisplayObj(UINames.LR_GIFTPAD_001) as Sprite;
      giftKing_mc = _form["giftKing_mc"];
      comboKing_mc = _form["comboKing_mc"];
      glow1 = _form["glow1"];
      glow2 = _form["glow2"];
      glow1.addEventListener(Event.ENTER_FRAME, glowHandler);
      glow2.addEventListener(Event.ENTER_FRAME, glowHandler);
      glow1.gotoAndStop(31);
      glow2.gotoAndStop(31);
      this.addChild(_form);
    }

    private function glowHandler(event:Event):void {

    }



  }
}
