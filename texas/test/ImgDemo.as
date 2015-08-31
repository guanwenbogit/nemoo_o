/**
 * Created by wbguan on 2015/7/31.
 */
package {


  import game.element.Poker;

  import starling.core.Starling;

  import starling.display.DisplayObject;

  import starling.display.Image;
  import starling.display.Sprite;
  import starling.events.Touch;
  import starling.events.TouchEvent;
  import starling.events.TouchPhase;
  import starling.textures.Texture;

  import textureSheet.TextureElement;

  import com.util.GButton;

  import com.util.ui.bitmapSheet.SheetPool;
  import com.util.ui.bitmapSheet.SheetPoolElement;

  public class ImgDemo extends Sprite {
    private var _img:Image;
    private var _texture:Texture;
    private var _sheetPool:SheetPool;
    private var _poker:Poker;
    private var _btn:GButton;

    public function ImgDemo() {
      super();

      initInstance();
      initBtn();
    }

    private function initBtn():void{
      var up:Texture = Texture.fromColor(50,50,0xffff0000);
      var down:Texture = Texture.fromColor(50,50,0xff00ff00);
      var over:Texture = Texture.fromColor(50,50,0xff0000ff);
      var dis:Texture = Texture.fromColor(50,50,0xffcccccc);
      _btn = new GButton(up,"",over,down,dis);
      this.addChild(_btn);
      _btn.x = 100;
      _btn.y = 100;

    }

    private function initInstance():void{
      _poker = new Poker();
      _sheetPool = new SheetPool(TextureElement);
      _sheetPool.getSheetMap("poker_game1.png","poker_game1.json",onSheetBack);

    }

    private function onSheetBack(element:SheetPoolElement):void {
      if(element is TextureElement){
        var tmp:TextureElement = element as TextureElement;
        _texture = tmp.getTexture("Spade_10.png");
        _img = new Image(_texture);
        _poker.setTexture(_texture,tmp.getTexture("Poker_0.png"));
        _poker.showBack();
        this.addChild(_poker);
        this.addEventListener(TouchEvent.TOUCH, onTouch);

      }
    }

    private function onTouch(event:TouchEvent):void {
      var touch:Touch = event.getTouch(event.currentTarget as DisplayObject)
      if(touch!=null) {
        trace("touch " + touch.phase);
        if(touch.phase == TouchPhase.ENDED){
          _poker.turn();
        }
      }else{
        trace("touch null");
      }
    }

  }
}
