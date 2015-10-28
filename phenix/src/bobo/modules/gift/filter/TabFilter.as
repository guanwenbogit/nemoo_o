package bobo.modules.gift.filter {
  import bobo.modules.gift.GiftInfo;
  import bobo.modules.gift.IGiftFilter;
  import com.util.PropretiesFilter;

  /**
   * @author wbguan
   */
  public class TabFilter extends Object implements IGiftFilter {
    
    private var value:String = "";
    public function TabFilter(value:String) {
      this.value = value;
    }

    public function run(arr:Vector.<GiftInfo>):Vector.<GiftInfo> {
      // TODO: Auto-generated method stub
      var source:Vector.<Object> = Vector.<Object>(arr);
      return Vector.<GiftInfo>(PropretiesFilter.includeFilter(source, "giftGroup", value));
    }
    public function get filterName():String{
      return "TabFilter" + value;
    }
  }
}
