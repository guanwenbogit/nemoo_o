package bobo.modules.gift.filter {
  import bobo.config.InitConfig;
  import bobo.modules.gift.GiftInfo;
  import bobo.modules.gift.IGiftFilter;
  import bobo.util.PropretiesFilter;

  /**
   * @author wbguan
   */
  public class RoomSimpleFilter extends Object implements IGiftFilter {
    public function RoomSimpleFilter() {
    }

    public function run(arr:Vector.<GiftInfo>):Vector.<GiftInfo> {
      var result:Vector.<GiftInfo> = new Vector.<GiftInfo>();
      var len:int = arr.length;
      var roomType:int = InitConfig.roomShowType();
      for(var i:int = 0;i<len;i++){
        var obj:GiftInfo = arr[i];
        var show:int = obj.roomShowType;
        var type:int = obj.type;
        var isHide:Boolean = obj.isHide;
        if(PropretiesFilter.hasAttribute(roomType,show)// 是不是在本房间显示
         && type != 2 //是不是包裹礼物
         && !isHide // 是不是上线或不再flash端显示
         && showInRoom(obj.bindToRoom)
        ){
          result.push(obj);
        }
      }
      return result;
    }
    public function get filterName():String{
      return "RoomSimpleFilter";
    }

    private function showInRoom(roomId : int) : Boolean {
      if(roomId == 0 || roomId == InitConfig.roomId){
        return true;
      }
      return false;
    }
  }
}
