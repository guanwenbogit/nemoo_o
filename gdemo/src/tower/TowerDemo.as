/**
 * Created by wbguan on 2015/2/28.
 */
package tower {
  import flash.display.Bitmap;
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.MouseEvent;
  import flash.events.TimerEvent;
  import flash.net.URLRequest;
  import flash.system.System;
  import flash.utils.Timer;

  import util.ui.unity.LRButton;

  import unity.progressBar.LRTower;
  import unity.progressBar.LRTowerGroup;
  import unity.progressBar.LRTowerInfo;

  public class TowerDemo extends Sprite {
    private var _max:int = 1;
    private var _loader:Loader;
    private var _tower:LRTower;
    private var _towers:Array = new Array();
    private var _start:LRButton;
    private var _count:int = 0;
    private var _group:LRTowerGroup;
    private var _timer:Timer = new Timer(100);
    public function TowerDemo() {
      super();
      this._start = new LRButton("on/off");
      this.addChild(this._start);
      this._start.addEventListener(MouseEvent.CLICK, onClick);
      _loader=new Loader();
      var req:URLRequest = new URLRequest("chip.png");
      _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete2);
      this._timer.addEventListener(TimerEvent.TIMER, onFrame);
      _loader.load(req);
    }

    private function onClick(event:MouseEvent):void {
      if(this._timer.running){
        this._timer.stop();
      }else{
        this._timer.start();
      }
    }

    private function onFrame(event:Event):void {
//      var num:int = int(_count/10);
//      for each(var t:LRTower in this._towers) {
//        t.setFloor(_count);
//        t.render();
//      }

      this._group.setNum(_count);
      this._group.render();
      _count+=123;
      if(_count>=28234){
        _count = 0;
      }
    }

    private function onComplete2(event:Event):void{
      var target:LoaderInfo = event.target as LoaderInfo;
      var bit:Bitmap = target.content as Bitmap;
      var spans:Vector.<int> = new <int>[100,50,20,10,5,1];
      var info:LRTowerInfo = new LRTowerInfo;
      info.displayObj = bit;
      info.margin = -40;
      var infos:Vector.<LRTowerInfo> = new <LRTowerInfo>[info,info,info,info,info,info];
      _group = new LRTowerGroup(spans,infos);
      _group.setNum(1);
      _group.render();
      _group.y =100;
      this.addChild(_group);
    }

    private function onComplete(event:Event):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      var bit:Bitmap = target.content as Bitmap;
      for(var i:int = 0;i<_max;i++){
        this._tower = new LRTower(bit,-40);
        this._towers.push(this._tower);
        this.addChild(_tower);
        this._tower.y = int(i/10)*60 + 0;
        this._tower.setFloor(1);
        this._tower.render();
        this._tower.x = (i%10)*this._tower.width + 100;
      }
    }

  }
}
