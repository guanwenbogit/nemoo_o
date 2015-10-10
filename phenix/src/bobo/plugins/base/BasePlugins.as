/**
 * Created by wbguan on 2015/10/10.
 */
package bobo.plugins.base {
  import bobo.plugins.IPlugins;


  import flash.display.Sprite;

  import robotlegs.bender.framework.impl.Context;

  public class BasePlugins extends Sprite implements IPlugins {
    protected var context:Context;
    protected var configClazz:Class;
    public function BasePlugins() {
      super();
    }

    /*
     * args[context,param1,param2,....]
     * context is the instance of the robotlegs Context Class.
     * */
    public function init(...args):void {
      context = args[0];
      config();
      if(configClazz == null) {
        throw new Error("Can not find the config class,please override the config method and set the configClass ");
      }else{
        this.context.configure(configClazz);
      }
    }


    protected function config():void {

    }

  }
}
