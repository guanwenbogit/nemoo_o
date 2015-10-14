/**
 * Created by wbguan on 2015/8/31.
 */
package tools.uiProvider {
  import com.util.ui.bitmapSheet.SheetPoolElement;


  import com.util.ui.bitmapSheet.SheetPool;

  import flash.display.Loader;
  import flash.events.Event;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;


  public class NProvider extends Object {
    private static var _pool:SheetPool = new SheetPool();
    private static var _orgs:Object = {};
    private static var _swfs:Object = {};

    public function NProvider() {
      super();
    }

    /*
     * callBack(loader:Loader)
     * */
    public static function loadSwf(url:String, callBack:Function,force:Boolean = false):void {
      if (_swfs[url] == null) {
        var loader:Loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function handler(event:Event):void {
          _swfs[url] = loader;
          callBack(loader);
        });
        trace("NProvider load " +url);
        loader.load(new URLRequest(url), new LoaderContext(true, ApplicationDomain.currentDomain));
      } else {
        if(force){
          loader = _swfs[url];
          loader.unloadAndStop();
          _swfs[url] = null;
          delete _swfs[url];
          loadSwf(url,callBack,false);
        }else {
          callBack(_swfs[url]);
        }
      }
    }
    /*
     * callBack(org:Norg)
     * */
    public static function loadOrg(url:String, jsonUrl:String, callBack:Function):void {
      trace("NProvider loadOrg " +url);
      if (_orgs[url] == null) {
        _pool.getSheetMap(url, jsonUrl, function back(ele:SheetPoolElement):void {
          var org:NOrg = new NOrg(ele);
          _orgs[url] = org;
          callBack(org);
        })
      } else {
        callBack(_orgs[url]);
      }
    }

    public static function getOrg(url:String):NOrg {
      var org:NOrg;
      org = _orgs[url]
      return org;
    }

  }
}
