package util.artFont {

  import util.ui.bitmapSheet.Frame;


  /**
   * @author wbguan
   */
  public class FontStyleConfig extends Object {
    protected static var map:Object = new Object();

    public function FontStyleConfig() {
    }

    public static function getFrames(font:String):Vector.<Frame> {
      var result:Vector.<Frame> = new Vector.<Frame>();
      if (!map.hasOwnProperty(font)) {
        init(font);
      }
      result = map[font];
      return result;
    }

    public static function getFrameByIndex(font:String, index:String):Frame {
      var frames:Vector.<Frame> = getFrames(font);
      var result:Frame = frames[index];
      return result;
    }

    private static function init(font:String):void {
      switch(font) {
        case FontStyle.NORMAL:
          map[FontStyle.NORMAL] = getNormalFrames();
          break;
        case FontStyle.COUNTDOWN:
          map[FontStyle.COUNTDOWN] = getCountDownFrames();
          break;
      }
    }
    private static function getCountDownFrames():Vector.<Frame> {
      var result:Vector.<Frame> = new Vector.<Frame>();
      for each (var source:Object in CountDownFont.frames) {
        var frame:Frame = new Frame(source);
        result.push(frame);
      }
      return result;
    }
    private static function getNormalFrames():Vector.<Frame> {
      var result:Vector.<Frame> = new Vector.<Frame>();
      for each (var source:Object in NormalFrames.frames) {
        var frame:Frame = new Frame(source);
        result.push(frame);
      }
      return result;
    }
  }
}
