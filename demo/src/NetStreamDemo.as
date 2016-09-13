/**
 * Created by guanwenbo on 2016/8/18.
 */
package {
    import flash.display.Sprite;
    import flash.events.NetStatusEvent;
    import flash.media.Video;
    import flash.net.NetConnection;
    import flash.net.NetStream;

    public class NetStreamDemo extends Sprite {
        private var _nc:NetConnection;
        private var _ns:NetStream;
        private var _video:Video;
        public function NetStreamDemo() {
            super();
            _nc = new NetConnection();
            _nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);

            _video = new Video();
            this.addChild(_video);
            _nc.connect(null);

        }

        private function onNetStatus(event:NetStatusEvent):void {
            trace("[NetStreamDemo->onNetStatus 26] " +event.info.code);
            if(event.info.code == "NetConnection.Connect.Success"){
                if(!_ns) {
                    _ns = new NetStream(_nc);
                    _ns.client = this;
                    _video.attachNetStream(_ns);
                    _ns.play("http://pl3.live.panda.tv/live_panda/d4e0a83a7e0b0c6e4c5d03774169fa3e.flv");
                    _ns.addEventListener(NetStatusEvent.NET_STATUS, onStreamStatus);
                }

            }
        }

        private function onStreamStatus(event:NetStatusEvent):void {
            trace("[NetStreamDemo->onStreamStatus 39] "+JSON.stringify(event.info));
        }

        public function onMetaData(info:Object):void{
            trace(JSON.stringify(info));
        }
    }
}
