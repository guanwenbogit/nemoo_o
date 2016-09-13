/**
 * Created by guanwenbo on 2016/9/13.
 */
package com.util.ui.unity {

    import com.util.ui.scrollbar.LRScrollerBar;

    import flash.display.DisplayObject;
    import flash.display.MovieClip;


    public class HandlerBar extends LRProgressBar {
        private var _scrollerBar:LRScrollerBar;
        public var onHandler:Function ;
        public function HandlerBar(scroller:LRScrollerBar) {
            super(scroller.distance);
            _scrollerBar = scroller;
            _scrollerBar.onScolling = onScrolling;
            this.addChild(_scrollerBar);
        }

        private function onScrolling():void{
            var progress:Number = _scrollerBar.rate;
            super.setProgress(int(progress*100));
            if(onHandler){
                this.onHandler();
            }
        }


        override public function setProgress(param:uint):void {
            super.setProgress(param);
            if(_scrollerBar){
                _scrollerBar.rate = 1.0*param/_max;
            }
        }

        override public function setBar(bar:DisplayObject, x:int = 0, y:int = 0):void {
            super.setBar(bar, x, y);
            this.addChild(_scrollerBar);
        }

        override public function setCore(param:DisplayObject, header:MovieClip = null, x:int = 0, y:int = 0):void {
            super.setCore(param, header, x, y);
            this.addChild(_scrollerBar);
        }

        override public function dispose():void {
            super.dispose();
            if(_scrollerBar){
                _scrollerBar.dispose();
            }
            onHandler = null;
        }
    }
}
