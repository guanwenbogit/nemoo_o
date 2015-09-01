/**
 * Created by wbguan on 2015/8/31.
 */
package tools.uiProvider {
  import com.util.ui.bitmapSheet.SheetPoolElement;



  import com.util.ui.bitmapSheet.SheetPool;


  public class NProvider extends Object {
    private static var _pool:SheetPool = new SheetPool();
    private static var _orgs:Object = {};
    public function NProvider() {
      super();
    }
    public static function loadOrg(url:String,jsonUrl:String,callBack:Function):void{
      if(_orgs[url] == null) {
        _pool.getSheetMap(url, jsonUrl, function back(ele:SheetPoolElement) {
          var org:NOrg = new NOrg(ele);
          _orgs[url] = org;
          callBack(org);
        })
      }else{
        callBack(_orgs[url]);
      }
    }
    public static function getOrg(url:String):NOrg{
      var org:NOrg;
      org = _orgs[url]
      return org;
    }

  }
}
