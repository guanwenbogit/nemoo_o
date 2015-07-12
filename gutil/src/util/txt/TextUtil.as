package util.txt {
  import flash.text.TextField;
  import flash.text.TextFieldAutoSize;
  import flash.text.TextFormat;

  public class TextUtil
  {
    public function TextUtil()
    {
    }
    
    public static function formatYaHei(textField : TextField) : void {
      if(!textField) return;
      var tf : TextFormat = textField.defaultTextFormat;
      tf.font = "Microsoft YaHei,微软雅黑";
      textField.defaultTextFormat = tf;
      textField.setTextFormat(tf);
    }
    
    public static function formatYaHeiAndBold(textField : TextField) : void {
      if(!textField) return;
      var tf : TextFormat = textField.defaultTextFormat;
      tf.font = "Microsoft YaHei,微软雅黑";
      tf.bold = true;
      textField.defaultTextFormat = tf;
      textField.setTextFormat(tf);
    }
    
    public static function setFormat(txt:TextField, color:uint, size:int, enable:Boolean = false,bold:String = ""):void {
      var tf:TextFormat = txt.defaultTextFormat;
      tf.bold = bold;
      tf.leading = 0;
      tf.color = color;
      tf.size = size;
      txt.defaultTextFormat = tf;
      TextUtil.formatYaHei(txt);
      txt.autoSize = TextFieldAutoSize.LEFT;
      txt.mouseEnabled = enable;
    }
    
    
    public static function moreStr(target : TextField, content : String, width : int) : void {
      target.text = "";
      for (var i:int = 0; i < content.length; i++) {
        target.appendText(content.charAt(i));
        if(target.textWidth > width){
          target.text = content.substr(0, i) + "...";
          break;
        }
      }
    }
    
    public static function getSysTF(color:uint, size:int,font:String = "",bold:String = ""):TextFormat{
      var result:TextFormat;
      result = new TextFormat();
      if(font.length==0){
        font = "Microsoft YaHei,微软雅黑";
      }
      result.bold = bold;
      result.font = font;
      result.color = color;
      result.size = size;
      return result;
    }
    
    
  }
}