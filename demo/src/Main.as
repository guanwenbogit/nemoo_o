package {

    import bb.BitmapBarrage;

    import flash.display.Shape;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.utils.getTimer;
    [SWF (backgroundColor = "0x000000" ,width = "1024",height ="768")]
    public class Main extends Sprite {
        private var _bb:BitmapBarrage;
        private var _flag:Boolean = false;
        public function Main() {
           _bb = new BitmapBarrage(1024,768);
            var shape:Shape = new Shape();
            shape.graphics.beginFill(0xff00ff);
            shape.graphics.drawRect(0,0,1024,768);


            shape.graphics.endFill();
            this.addChild(shape);
            this.addChild(_bb);
            _bb.lineHeight = 20;
            this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown)
        }

        private function onKeyDown(event:KeyboardEvent):void {
            if(event.keyCode == Keyboard.ENTER) {
                this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
            if(event.keyCode == Keyboard.SPACE){
                var last:Number = getTimer();
                for(var i:int = 0 ;i < 1 ; i++) {
                    _bb.addContent("" + getTimer());
                }
                trace("[Main->onKeyDown 32] timer :"+(getTimer() - last));
            }
            if(event.keyCode == Keyboard.P){
                _flag = !_flag;
//                this.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            }
        }

        private function onEnterFrame(event:Event):void {

            if(_flag) {
                _bb.addContent("" + getTimer());
            }
            _bb.render2();
        }
    }
}
