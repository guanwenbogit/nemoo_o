package bobo.util.net {
  import flash.utils.getDefinitionByName;
  /**
   * @author sytang
   */
  public class CryptoToken {
    //----------------------------------
    //  token
    //----------------------------------
    private var _token:String;
    public function get token():String {
      return _token;
    }
    //----------------------------------
    //  time
    //----------------------------------
    private var _time:String;
    public function get time():String {
      return _time;
    }
    //----------------------------------
    //  rand
    //----------------------------------
    private var _rand:String;
    public function get rand():String {
      return _rand;
    }
    //----------------------------------
    //  ct
    //----------------------------------
    private var _ct:String;
    public function get ct():String {
      return _ct;
    }
    public function gen(t:String):void {
      _token = t;
      _time = String((new Date()).time);
      _rand = String(Math.random()).split(".")[1];
      var c:Class = getDefinitionByName("com.support.Crypto1") as Class;
      var c1:Object = new c();
      _ct = c1.c2(_token, _time, _rand);
    }
  }
}
