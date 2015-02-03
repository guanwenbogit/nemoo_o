/**
 * Created by wbguan on 2015/1/29.
 */
package mk.init {
  import flash.events.EventDispatcher;
  import flash.events.MouseEvent;

  import mk.container.InitContainer;
  import system.api.IScene;
  import system.util.container.IContainer;

  public class InitScene extends EventDispatcher implements IScene {
    private var _container:InitContainer;
    public function InitScene() {
      super();
      initInstance();
    }
    protected function initInstance():void{
      this._container = new InitContainer();
      this._container.addEventListener(MouseEvent.CLICK,onClick);
    }

    private function onClick(event:MouseEvent):void {
      this.dispatchEvent(event);
    }
    public function update(obj:Object):void {
      this._container.show();
    }

    public function remove():void {
      this._container.remove();
    }

    public function get container():IContainer {
      return _container;
    }
  }
}
