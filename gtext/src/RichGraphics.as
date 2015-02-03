/**
 * Created by wbguan on 2015/1/22.
 */
package {
  import flash.system.ApplicationDomain;

  import image.ImageHelper;

  public class RichGraphics {
    protected var _ginfos:Vector.<GraphicsInfo> = new Vector.<GraphicsInfo>();
    public function RichGraphics() {
      init();
    }
    public function init():void{

    }
    public function getInfoByStr(str:String):GraphicsInfo{
      var result:GraphicsInfo;
      var arr:Array = parseStr(str);
      if(arr.length == 2){
        var type:String = arr[0];
        result = getInfoByKey(str,type);
      }
      return result;
    }
    private function getInfoByKey(key:String,type:String):GraphicsInfo{
      var result:GraphicsInfo;
      if(type == "l"){
        result = new GraphicsInfo();
        result.key = key
      }else {
        for each(var info:GraphicsInfo in this._ginfos) {
          if (info.key == key) {
            result = info;
            setupGraphics(result, type);
          }
        }
      }
      return result;
    }
    private function setupGraphics(g:GraphicsInfo,type:String):void{
      if(g!= null && g.g ==  null){
        if(type == "u"){
          g.g = ImageHelper.instance.getImageBitMap(g.url,g.w,g.h,null,false,0);
        }else if(type == "c"){
          if(ApplicationDomain.currentDomain.hasDefinition(g.url)){
            var c:Class = ApplicationDomain.currentDomain.getDefinition(g.url) as Class;
            g.g = new c();
          }
        }
      }
    }
    private function parseStr(str:String):Array{
      var result:Array = [];
      result = str.split(":");
      return result;
    }
  }
}
