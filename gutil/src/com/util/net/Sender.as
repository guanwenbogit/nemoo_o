/**
 * Created by wbguan on 2015/4/24.
 */
package com.util.net {
  import com.util.net.socket.SocketServer;

  public class Sender extends Object {
    private var _socket:SocketServer;
    public function Sender() {
      super();
    }

    public function init(param:SocketServer):void{
      _socket = param;
    }

    public function send(value:String):void{
      _socket.send(value);
    }
  }
}
