package bobo.modules.gift {
  import bobo.modules.gift.filter.RoomSimpleFilter;
  import bobo.modules.gift.filter.TabFilter;


  /**
   * @author wbguan
   */
  public class GiftBuffer extends Object {
    public static var  map:Object = {};

    public function GiftBuffer() {
    }

    public static function getGiftList(key:String, source:Vector.<GiftInfo>, filter:IGiftFilter, refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo>;
      result = map[key];
      if (result == null || refresh) {
        trace("[GiftBuffer/getGiftList]============= result : " + (result == null));
        trace("[GiftBuffer/getGiftList]============= refresh : " + refresh);
        trace("[GiftBuffer/getGiftList]============= key : " + key);
        result = GiftBuffer.filter(source, filter);
        map[key] = result;
      }
      trace("[GiftBuffer/getGiftList]============= result len : " + result.length);
      return result;
    }

    protected static function filter(source:Vector.<GiftInfo>, f:IGiftFilter):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo>;
      if (f != null) {
        result = f.run(source);
      } else {
        result = source;
      }
      return result;
    }

    /**
     * tabType(GiftType.NORMAL,GiftType.ADVANCED,GiftType.SPECIAL)
     */
    public static function getTabList(tabType:String, refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo> ;
      var filter:IGiftFilter = new TabFilter(tabType);
      var source:Vector.<GiftInfo> = getRoomSimpleList();
      result = getGiftList(tabType, source, filter, refresh);
      return result;
    }

    public static function getGiftListBaseSource(key:String, filter:IGiftFilter, refresh:Boolean = false):Vector.<GiftInfo> {
      return getGiftList(key, GiftConfig.source, filter, refresh);
    }

    private static var roomFilter:IGiftFilter = new RoomSimpleFilter();

    public static function getRoomSimpleList():Vector.<GiftInfo> {
      var result:Vector.<GiftInfo>;
      result = getGiftListBaseSource(roomFilter.filterName, roomFilter);
      return result;
    }

    /**
     * tabType(GiftType.NORMAL,GiftType.ADVANCED,GiftType.SPECIAL)
     */
    public static function getListBaseTab(tabType:String, bufferKey:String, filter:IGiftFilter, refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo>;
      var source:Vector.<GiftInfo> = getTabList(tabType, refresh);
      result = getGiftList(bufferKey, source, filter, refresh);
      return result;
    }

    public static function showGift(id:int):Boolean {
      var result:Boolean = false;
      var info:GiftInfo = GiftConfig.getGiftInfoById(id);
      if (info != null) {
        if (info.isHide) {
          info.isHide = false;
          result = true;
        }
      }
      return result;
    }

    public static function hideGift(id:int):Boolean {
      var result:Boolean = false;
      var info:GiftInfo = GiftConfig.getGiftInfoById(id);
      if (info != null) {
        if (!info.isHide) {
          info.isHide = true;
          result = true;
        }
      }
      return result;
    }

    public static function refresh():void {
      getGiftListBaseSource(roomFilter.filterName, roomFilter, true);
    }

    public static function normalList(refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo> ;
      var key:String = GiftType.NORMAL;
      result = getTabList(key, refresh);
      return result;
    }

    public static function advancedList(refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo> ;
      var key:String = GiftType.ADVANCED;
      result = getTabList(key, refresh);
      return result;
    }

    public static function specialList(refresh:Boolean = false):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo> ;
      var key:String = GiftType.SPECIAL;
      result = getTabList(key, refresh);
      return result;
    }

    public static function clearBuffer(key:String):void {
      if (GiftBuffer.map.hasOwnProperty(key)) {
        map[key] = null;
        delete map[key];
      }
    }

    public static function clearAll():void {
      map = {};
    }
  }
}
