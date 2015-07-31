/**
 * Created by wbguan on 2015/7/31.
 */
package game.element {
  import starling.display.Image;
  import starling.display.Sprite;
  import starling.textures.Texture;

  public class Poker extends Sprite {

    private var _img:Image;
    private var _back:Texture;
    private var _face:Texture;
    private var _isBack:Boolean = false;
    public function Poker() {
      super();

    }
    public function setTexture(face:Texture,back:Texture):void{
      _back = back;
      _face = face;
    }

    private function setImg():void{
      if(_img == null){
        _img = new Image(_back);
        this.addChild(_img);
      }
      if(_isBack){
        _img.texture = _back;
      }else{
        _img.texture =  _face;
      }
    }
    public function showBack():void{
      _isBack = true;
      setImg();
    }

    public function showFace():void{
      _isBack = false;
      setImg();
    }

    public function turn():void {
      if(_isBack){
        showFace();
      }else{
        showBack();
      }
    }

  }
}
