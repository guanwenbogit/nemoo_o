package bobo.modules.gift {
  /**
   * @author wbguan
   */
  public interface IGiftFilter {
    function run(arr:Vector.<GiftInfo>):Vector.<GiftInfo>;
    function get filterName():String
  }
}
