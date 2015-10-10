/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.subDemo {
  import bobo.plugins.base.BasePlugins;

  import com.util.ui.list.LRRadioBtnList;

  public class SubMain extends  BasePlugins{
    public function SubMain() {
      super();
    }

    override protected function config():void {
      super.config();
      this.configClazz = SubConfig;
    }

    override public function init(...args):void {
      super.init.apply(this,args);
      var test:SubTestView = new SubTestView();
      this.addChild(test);
      new LRRadioBtnList();
    }

  }
}
