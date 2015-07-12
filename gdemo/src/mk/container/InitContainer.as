/**
 * Created by wbguan on 2015/1/30.
 */
package mk.container {
  import flash.display.Sprite;

  import util.ui.shape.LRRoundRectangle;

  import system.util.container.OContainer;

  public class InitContainer extends OContainer {
    private var _form:Sprite;
    private var _rect:LRRoundRectangle;
    public function InitContainer() {
      this._form = new Sprite();
      super(this._form);
      initInstance();
    }
    protected function initInstance():void{
      _rect = new LRRoundRectangle(50,50,10);
      this._form.addChild(_rect);
    }
  }
}
