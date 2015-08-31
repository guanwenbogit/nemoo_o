/**
 * Created by wbguan on 2015/8/31.
 */
package tools.uiProvider {
  import flash.display.BitmapData;

  import tools.uiProvider.NOrg;

  import util.ui.bitmapSheet.SheetPool;
  import util.ui.unity.NButton;

  public class NProvider extends Object {
    private var _pool:SheetPool;
    private var _orgs:Object = {};
    public function NProvider() {
      super();
      _pool = new SheetPool();
    }
    public function append(name:String,json:Object,bitmapData:BitmapData):void{
      if(_pool != null){
        var org:NOrg = this._orgs[name];
        if(org == null) {
          org = new NOrg(_pool.getElement(name, json, bitmapData));
          this._orgs[name] = org;
        }
      }
    }
    public function getOrg(name:String):NOrg{
      return _orgs[name];
    }

  }
}
