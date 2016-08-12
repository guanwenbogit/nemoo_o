/**
 * Created by guanwenbo on 2016/8/12.
 */
package {

    import bb.GridBarrage;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.getTimer;
    [SWF (backgroundColor = "0x000000" ,width = "1024",height ="768")]
    public class MainGroup extends Sprite {

        private var _barrage:GridBarrage;




        public function MainGroup() {
            super();
            _barrage = new GridBarrage(1024,768,20);

            this.addChild(_barrage);
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown)
        }

        private function onKeyDown(event:KeyboardEvent):void {

            if(event.keyCode == Keyboard.ENTER) {
                this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            if(event.keyCode == Keyboard.SPACE){
                var last:Number = getTimer();
                for(var i:int = 0 ;i < 100 ; i++) {
                    _barrage.addContent(getTimer()+"");
                }
            }
            if(event.keyCode == Keyboard.P){


            }
        }

        private function onEnterFrame(event:Event):void {
//            for(var i:int = 0 ;i < 1 ; i++) {
//                _barrage.addContent(getTimer()+"");
//            }
            _barrage.render();
        }

    }
}
