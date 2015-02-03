/**
 * Created by wbguan on 2015/1/23.
 */
package system.mould {
  import avmplus.getQualifiedClassName;

  import system.api.ISysMould;

  import system.api.hub.HubPool;

  public class Mould implements ISysMould {
    protected var _name:String = "";
    protected var _inside:HubPool;
    private var _outside:HubPool;
    public function get name():String{
      return this._name;
    }
    public function dispose():void {
    }
    public function Mould(hubPool:HubPool) {
      this._outside = hubPool;
      this._name = getQualifiedClassName(this);
      this._inside = new HubPool();
      this.init();
    }
    protected function init():void {
      trace("mould ["+this.name+"] init");
    }

    public function callBack(...args) {
    }

    public function get outside():HubPool {
      return _outside;
    }

  }
}
