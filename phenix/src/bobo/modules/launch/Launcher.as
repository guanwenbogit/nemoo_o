/**
 * Created by wbguan on 2015/4/28.
 */
package bobo.modules.launch {

  import com.util.launcher.LaunchManager;
  import com.util.launcher.LauncherEvent;

  import org.osflash.signals.Signal;

  public class Launcher extends Object {
    private var _launcher:LaunchManager;
    public var launchSignal:Signal = new Signal();
    private var _flag:Boolean = false;
    public function Launcher() {
      super();
    }
    /*
     * [{name:name1,url:url1},{name:name2,url:url2}]
     * */
    public function init(param:Array):void{
      if(_launcher == null){
        _launcher = new LaunchManager();
      }
      var assets:Array = param;
      if(assets!=null&&assets.length>0) {
        _launcher.prepare(assets,3);
      }
      if(!_launcher.dispatcher.hasEventListener(LauncherEvent.SETUP_EVENT)) {
        _launcher.dispatcher.addEventListener(LauncherEvent.SETUP_EVENT, onStep);
      }
    }
    public function setup():void{
      _flag = true;
      if(this._launcher!= null){
        _launcher.setup();
      }
    }
    public function launch(name:String,url:String):void{
      var arr:Array = [{"name":name,"url":url}];
      _launcher.prepare(arr);
    }
    /*
    * [{name:name1,url:url1},{name:name2,url:url2}]
    * */
    public function launchMultiple(arr:Array):void{
      _launcher.prepare(arr,3);
    }

    private function onStep(event:LauncherEvent):void {
      var name:String = String(event.param);
      launchSignal.dispatch(name);
    }
    private function getAssets(param:Object):Array{
      var arr:Array = [];
      arr.push({name:"base",url:"base.swf"});
      return arr;

    }
    public function dispose():void{
      _launcher.dispose();
    }

    public function addLauncherSignal(hanlder:Function):void {
      this.launchSignal.add(hanlder);
    }

    public function removeSignal(onLaunch:Function):void {
      this.launchSignal.remove(onLaunch);
    }
  }
}
