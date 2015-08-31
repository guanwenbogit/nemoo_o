/**
 * Created by wbguan on 2015/4/30.
 */
package com.util.ui.list {
  import com.greensock.TweenLite;

  public class LRTweenInOutList extends LRInOutList {
    private var _tweenIn:Array = [];
    private var _tweenOut:Array = [];
    public function LRTweenInOutList(clazz:Class, margin:int = 5, range:String = "down") {
      super(clazz, margin, range);
    }

    override protected function renderOut(flag:Boolean):void {
    }

    override protected function renderIn(flag:Boolean):void {
    }
  }
}
