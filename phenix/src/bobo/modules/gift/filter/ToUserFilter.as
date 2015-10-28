package bobo.modules.gift.filter {
  import bobo.modules.gift.GiftInfo;
  import bobo.modules.gift.IGiftFilter;
  import com.util.PropretiesFilter;

  /**
   * @author wbguan
   */
  public class ToUserFilter extends Object implements IGiftFilter {
    public function ToUserFilter() {
    }
    // there would be more and more logic to filter the gift
    public function run(arr:Vector.<GiftInfo>):Vector.<GiftInfo> {
      // TODO: Auto-generated method stub
      var result:Vector.<GiftInfo>;
      var source:Vector.<Object> = Vector.<Object>(arr); 
      result = Vector.<GiftInfo>(PropretiesFilter.excludeFilter(source, "forbidToUser", true));
      return result;
    }

    public function get filterName():String {
      // TODO: Auto-generated method stub
      return "ToUserFilter";
    }
  }
}
