package com.util.launcher {
  import flash.events.Event;

  /**
   * @author wbguan
   */
  public class AssetEvent extends Event {
    public static const COMPLETE_EVENT:String = "COMPLETE_EVENT";
	public static const ERROR_EVENT : String = "ERROR_EVENT";
	public static const INIT_EVENT:String = "INIT_EVENT";
	public static const SECURITY_ERROR_EVENT:String = "SECURITY_ERROR_EVENT";
	
    
    private var _data:Asset;
    public function AssetEvent(type:String,data:Asset, bubbles:Boolean = true, cancelable:Boolean = false) {
      this._data = data;
      super(type, bubbles, cancelable);
    }
    override public function clone():Event{
      return new AssetEvent(type, this._data,bubbles,cancelable);
    }
    
    public function get name():String {
      var result:String = "";
      if(this._data != null){
        result = this._data.name;
      }
      return result;
    }
    
    public function get url():String {
      var result:String = "";
      if(this._data != null){
        result = this._data.url;
      }
      return result;
    }

    public function get data():Asset {
      return _data;
    }
    
  }
}
