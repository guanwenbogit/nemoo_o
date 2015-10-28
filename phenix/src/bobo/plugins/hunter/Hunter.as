/**
 * Created by wbguan on 2015/10/20.
 */
package bobo.plugins.hunter {
  import bobo.plugins.base.BasePlugins;

  public class Hunter extends BasePlugins {
    public function Hunter() {
      super();
    }

    override public function init(...args):void {
      super.apply.init(this,args);
    }
    public function initUI():void{

    }

  }
}
