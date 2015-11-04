/**
 * Created by wbguan on 2015/8/19.
 */
package {


  import bobo.config.InitConfig;
  import bobo.framework.RoomContext;
  import bobo.modules.main.MainView;
  import com.util.AlignUtil;

  import com.plugin.log.LogUtil;


  import flash.display.Sprite;
  import flash.display.StageAlign;
  import flash.display.StageScaleMode;
  import flash.events.Event;

  import robotlegs.bender.framework.impl.Context;



  [SWF(backgroundColor = 0xcccccc)]
  public class MainShell extends Sprite{
    private var _context:Context;
    public function MainShell() {
      super();
      this.addEventListener(Event.ADDED_TO_STAGE, onAdded)
    }

    private function onAdded(event:Event):void {
      this.stage.scaleMode = StageScaleMode.NO_SCALE;
      this.stage.align = StageAlign.TOP_LEFT;
      AlignUtil.init(this.stage);
      if(CONFIG::LOCALE){
        init(CustomProperties.params);
      }
    }

    public function init(param:Object):void {
      InitConfig.init(param);
      _context = new RoomContext(this);
      LogUtil.info("main shell ","MainShell");
      var main:MainView = new MainView();
      this.addChild(main);
      text();
    }

    private function text(...args):void{
      var param:Object = args[0];
      var param1:Object = args[1];
    }

  }
}
