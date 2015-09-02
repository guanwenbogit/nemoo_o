/**
 * Created by wbguan on 2015/5/25.
 */
package bobo.util.loader {
  import flash.display.Loader;
  import flash.display.LoaderInfo;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequest;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;

  public class InAppLoader extends Object {
    private static var _map:Object = {};
    private static var _func:Object = {};

    public function InAppLoader() {
      super();
    }

    /*
     * onLoaded(loader:Loader)
     * */
    public static function load(url:String, onLoaded:Function, cache:Boolean = true):void {
      var loader:Loader = _map[url];
      if (loader == null) {
        loader = new Loader();
        if (cache) {
          _map[url] = loader;
        }
        _func[loader.name] = [];
        _func[loader.name].push(onLoaded);

        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
        loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
        loader.load(new URLRequest(url), new LoaderContext(false, ApplicationDomain.currentDomain));
      } else {
        if (loader.contentLoaderInfo.bytesLoaded < loader.contentLoaderInfo.bytesTotal) {
          _func[loader.name].push(onLoaded);
        } else {
          if (onLoaded != null) {
            onLoaded(loader);
          }
        }
      }
    }

    private static function gc(target:LoaderInfo):void {
      for (var key:String in _map) {
        var tmp:Loader = _map[key]
        if (tmp != null && tmp == target.loader) {
          tmp.close();
          delete _map[key];
          break;
        }
      }
    }

    private static function onIOError(event:IOErrorEvent):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      var arr:Array = _func[target.loader.name];
      gc(target);
      while (arr.length > 0) {
        var func:Function = arr.pop();
        func(null);
      }
      delete  _func[target.loader.name]
    }

    private static function onSecurityError(event:SecurityErrorEvent):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      var arr:Array = _func[target.loader.name];
      gc(target);
      while (arr.length > 0) {
        var func:Function = arr.pop();
        func(null);
      }
      delete  _func[target.loader.name]
    }

    private static function onComplete(event:Event):void {
      var target:LoaderInfo = event.target as LoaderInfo;
      var arr:Array = _func[target.loader.name];
      var url:String = _map[target.loader.name];
      while (arr.length > 0) {
        var func:Function = arr.pop();
        func(target.loader);
      }
      delete  _func[target.loader.name]
    }

  }
}
