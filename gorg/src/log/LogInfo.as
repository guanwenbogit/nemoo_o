/**
 * Created by wbguan on 2015/7/15.
 */
package log {
  public class LogInfo {
    private var _date:Number = 0;
    private var _type:String = "";
    private var _message:String = "";
    private var _source:Object = {};
    public function LogInfo() {
    }

    public function get date():Number {
      return _date;
    }

    public function set date(value:Number):void {
      _date = value;
    }

    public function get type():String {
      return _type;
    }

    public function set type(value:String):void {
      _type = value;
    }

    public function get message():String {
      return _message;
    }

    public function set message(value:String):void {
      _message = value;
    }

    public function get source():Object {
      return _source;
    }

    public function set source(value:Object):void {
      _source = value;
    }
  }
}
