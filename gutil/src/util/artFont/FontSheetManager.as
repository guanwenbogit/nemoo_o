package util.artFont {
  import flash.system.ApplicationDomain;
  import flash.display.BitmapData;
  import flash.display.Bitmap;

  import util.ui.bitmapSheet.Frame;

  import util.ui.bitmapSheet.Sheet;

  /**
   * @author wbguan
   */
  public class FontSheetManager extends Object {
    protected static var _instance:FontSheetManager;
    public static function get instance():FontSheetManager{
      if(_instance == null){
        _instance = new FontSheetManager();
      }
      return _instance;
    }
    private var _map:Object = new Object();
    public function FontSheetManager() {
    }
     public function getCharBitmapData(char:String,font:String):BitmapData{
      var result:BitmapData ;
      var sheet:Sheet = getSheet(font);
      if(sheet != null){
        var frame:Frame = getFrame(char,font);
        result = sheet.getTileBitmapData(frame);
      }
      return result;
    }
    public function getCharBitmap(char:String,font:String):Bitmap{
      var result:Bitmap = new Bitmap();
      var sheet:Sheet = getSheet(font);
      if(sheet != null){
        var frame:Frame = getFrame(char,font);
        result = sheet.getTileBitMap(frame);
      }
      return result;
    }
    private function getFrame(char:String,font:String):Frame{
      var result:Frame;
      switch(font){
        case FontStyle.NORMAL:
        case FontStyle.COUNTDOWN:
          result = FontStyleConfig.getFrameByIndex(font,char);
        break;
      }
      return result;
    }
    protected function getSheet(font:String):Sheet{
      var result:Sheet;
      if(!_map.hasOwnProperty(font)){
        var c:Class;
        if(ApplicationDomain.currentDomain.hasDefinition(font)){
          c = ApplicationDomain.currentDomain.getDefinition(font) as Class;
          var bitMap:BitmapData = new c();
          _map[font] = new Sheet(bitMap);
          result = _map[font];
        }
      }else{
        result = _map[font]; 
      }
      return result;
    }
    
  }
}
