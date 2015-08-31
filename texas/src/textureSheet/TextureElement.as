/**
 * Created by wbguan on 2015/7/31.
 */
package textureSheet {
  import flash.geom.Rectangle;

  import starling.textures.Texture;

  import com.util.ui.bitmapSheet.Frame;

  import com.util.ui.bitmapSheet.SheetPoolElement;

  public class TextureElement extends SheetPoolElement {
    private var _texture:Texture;
    private var _rect:flash.geom.Rectangle;
    public function TextureElement() {
      super();
      _rect = new Rectangle();
    }

    override protected function init():void {
      super.init();
      if(_bitmapData !=null){
        _texture = Texture.fromBitmapData(this._bitmapData,false);
      }
    }

    public function getTexture(name:String):Texture{
      var result:Texture;
      for each(var frame:Frame in this._frames){
        if(frame.name == name&&_texture!=null) {
          _rect.x = frame.x;
          _rect.y = frame.y;
          _rect.width = frame.w;
          _rect.height = frame.h;
          result = Texture.fromTexture(_texture,_rect,null);
          break;
        }
      }
      return result;
    }

  }
}
