/**
 * Created by wbguan on 2015/4/24.
 */
package com.util.net.socket {
  import flash.events.Event;

  public class SocketEvent extends Event {
    public static const RECEIVED:String = "RECEIVED";
    public static const IO_ERROR:String = "IO_ERROR";
    public static const SECURITY_ERROR:String = "SECURITY_ERROR";
    public static const CLOSE:String = "CLOSE";
    public static const CONNECTED:String = "CONNECTED";
    private var _data:Object = {};
    public function SocketEvent(type:String, data:Object,bubbles:Boolean = false, cancelable:Boolean = false) {
      _data = data;
      super(type, bubbles, cancelable);
    }

    override public function clone():Event {
      return new SocketEvent(type,_data,bubbles,cancelable);
    }

    public function get data():Object {
      return _data;
    }
  }
}
