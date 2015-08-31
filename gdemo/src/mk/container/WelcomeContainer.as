/**
 * Created by wbguan on 2015/1/30.
 */
package mk.container {
  import flash.display.Sprite;
  import com.util.ui.shape.LRRoundRectangle;
  import system.util.container.OContainer;

  public class WelcomeContainer extends OContainer{
    private var _form:Sprite;
    private var _rect:LRRoundRectangle;
    public function WelcomeContainer() {
      this._form = new Sprite();
      super(this._form);
      initInstance();
    }
    protected function  initInstance():void{
      this._rect = new LRRoundRectangle(20,20,0x00ff00);
      this._rect.x = this._rect.y = 100;
      this._form.addChild(this._rect);
    }

  }
}
