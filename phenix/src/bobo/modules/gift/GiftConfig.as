package bobo.modules.gift {
  import flash.utils.Dictionary;
  /**
   * @author wbguan
   */
  public class GiftConfig extends Object {
    protected static var _source:Vector.<GiftInfo> = new Vector.<GiftInfo> ();
    protected static var _map:Object = {};
    public function GiftConfig() {
    }
    public static function init(source:Object):void{
      _source = new Vector.<GiftInfo>();
      var arr:Array = source["giftList"] as Array;
      for each(var obj:Object in arr){
        var info:GiftInfo = new GiftInfo(obj);
        GiftConfig._source.push(info);
        GiftConfig._map[info.id] = info;
      }
    }
    public static function getGiftInfoById(id:int):GiftInfo{
      var result:GiftInfo;
      result = _map[id];
      return result;
    }

    static public function get source():Vector.<GiftInfo>  {
      return _source;
    }
    
  }
}
