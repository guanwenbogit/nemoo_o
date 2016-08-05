package {

    import bb.BitmapBarrage;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.text.TextField;
    import flash.utils.getTimer;
    [SWF (backgroundColor = "0x000000")]
    public class Main extends Sprite {
        private var _bb:BitmapBarrage;
        public function Main() {
           _bb = new BitmapBarrage(500,300);
            this.addChild(_bb);
            this.addEventListener(Event.ENTER_FRAME,onEnterFrame);

        }

        private function onEnterFrame(event:Event):void {
            _bb.addContent(""+getTimer());
            _bb.render();
        }
    }
}
