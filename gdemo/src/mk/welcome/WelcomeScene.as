/**
 * Created by wbguan on 2015/1/30.
 */
package mk.welcome {
  import flash.events.EventDispatcher;
  import flash.events.IEventDispatcher;

  import mk.container.WelcomeContainer;

  import system.api.IScene;
  import system.util.container.IContainer;

  public class WelcomeScene extends EventDispatcher implements IScene {
    private var _c:WelcomeContainer;
    public function WelcomeScene(target:IEventDispatcher = null) {
      super(target);
      this._c = new WelcomeContainer();
    }

    public function update(obj:Object):void {
      this._c.show();
    }

    public function remove():void {
    }

    public function get container():IContainer {
      return this._c;
    }
  }
}
