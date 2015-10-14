/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.base {
  import bobo.plugins.IPlugins;
  import flash.display.Sprite;
  import robotlegs.bender.framework.impl.Context;

  public dynamic class BasePlugins extends Sprite implements IPlugins {
    protected var context:Context;
    protected var configs : Array = [];
    public function BasePlugins() {
      super();
    }

    /*
     * args[context,param1,param2,....]
     * context is the instance of the robotlegs Context Class.
     * */
    public function init(...args):void {
      context = args[0];
      this.context.configure.apply(context, configs);
      initView();
    }

    protected function initView():void {

    }

    public function dispose():void {
    }
  }
}
