/**
 * Created by wbguan on 2015/4/24.
 */
package com.util.net.socket {


  import flash.events.EventDispatcher;
  import flash.utils.getTimer;
  import flash.system.Security;
  import flash.events.SecurityErrorEvent;
  import flash.utils.ByteArray;
  import flash.events.ProgressEvent;
  import flash.events.IOErrorEvent;
  import flash.events.Event;

  import flash.net.Socket;

  public class SocketServer extends EventDispatcher{
    public var lastTime:Number;
    //----------------------------------
    //  addr
    //----------------------------------
    private var _addr:String;
    public function get addr():String {
      return _addr;
    }
    //----------------------------------
    //  port
    //----------------------------------
    private var _port:int;
    public function get port():int {
      return _port;
    }
    private var _policyPort:int;
    //----------------------------------
    //  isConnected
    //----------------------------------
    private var _isConnected:Boolean = false;
    public function get isConnected():Boolean {
      return _isConnected;
    }
    private var _split:String = "";
    //----------------------------------
    //  securityErrorSignal
    //----------------------------------

    //==========================================================================
    //  Variables
    //==========================================================================
    private var socket:Socket;

    public function init(addr:String,port:int,policyPort:int = 843,split:String = "\r\n"):void {
      _addr = addr;
      _port = port;
      _split = split;
      _policyPort = policyPort;
      trace("[SocketServer/init]", _addr, _port);

      Security.loadPolicyFile("xmlsocket://" + _addr + ":"+policyPort);
      socket = new Socket();
      socket.addEventListener(Event.CONNECT, socketConnectedHandler);
      socket.addEventListener(Event.CLOSE, socketCloseHandler);
      socket.addEventListener(IOErrorEvent.IO_ERROR, socketIOErrorHandler);
      socket.addEventListener(ProgressEvent.SOCKET_DATA, dataReceivedHandler);
      socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    }


    public function connect():void {
      socket.connect(_addr, _port);
    }
    
    public function reconnect():void {
      socket.removeEventListener(Event.CONNECT, socketConnectedHandler);
      socket.removeEventListener(Event.CLOSE, socketCloseHandler);
      socket.removeEventListener(IOErrorEvent.IO_ERROR, socketIOErrorHandler);
      socket.removeEventListener(ProgressEvent.SOCKET_DATA, dataReceivedHandler);
      socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
      
      Security.loadPolicyFile("xmlsocket://" + _addr + ":"+_policyPort);
      socket = new Socket();
      socket.addEventListener(Event.CONNECT, socketConnectedHandler);
      socket.addEventListener(Event.CLOSE, socketCloseHandler);
      socket.addEventListener(IOErrorEvent.IO_ERROR, socketIOErrorHandler);
      socket.addEventListener(ProgressEvent.SOCKET_DATA, dataReceivedHandler);
      socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
      socket.connect(_addr, _port);
    }

    public function send(value:String):void {
      if (!_isConnected || !socket.connected) {
        trace("[SOCKET NOT CONNECTED]", value, value.length);
        return;
      }
      if (!value) {
        return;
      }
      
      if (value.length <= 0) {
        return;
      }
      trace("[SEND " + getTimer() + " ]", value);
      var ba:ByteArray = new ByteArray();
      ba.writeUTFBytes(value);
      ba.writeUTFBytes(_split);
      ba.position = 0;
      socket.writeBytes(ba, 0, ba.bytesAvailable);
      socket.flush();
      lastTime = getTimer();
    }
    public function close():void {
      socket.close();
    }

    //==========================================================================
    //  Event handlers
    //==========================================================================
    
    private function securityErrorHandler(event:SecurityErrorEvent):void {
      trace("[SECURITY_ERROR " + getTimer() + " ]");
      this.dispatchEvent(new SocketEvent(SocketEvent.SECURITY_ERROR, event.text));
    }
    private function socketCloseHandler(event:Event):void {
      this._isConnected = false;
      trace("[CLOSE " + getTimer() + " ]");
      this.dispatchEvent(new SocketEvent(SocketEvent.CLOSE,null));
    }
    private function dataReceivedHandler(event:ProgressEvent):void {
      var ba:ByteArray = new ByteArray();
      socket.readBytes(ba, 0, event.bytesLoaded);
      var rawData:String = ba.readUTFBytes(event.bytesLoaded);
      trace("[RECEIVE " + getTimer() + " ]", rawData);
      this.dispatchEvent(new SocketEvent(SocketEvent.RECEIVED, rawData));

      var _temp:String = "";
      var _len:int = rawData.length;
      for(var i:int=0;i<_len;i++)
      {
        _temp += rawData.substr(i, 1).replace('\r', '').replace('\n', '').replace('\r\n', '');
      }
    }
    private function socketIOErrorHandler(event:IOErrorEvent):void {
      trace("[IO_ERROR " + getTimer() + " ]");
      this.dispatchEvent(new SocketEvent(SocketEvent.IO_ERROR, event.text));
    }
    private function socketConnectedHandler(event:Event):void {
      this._isConnected = true;
      this.dispatchEvent(new SocketEvent(SocketEvent.CONNECTED, null));
    }

    public function get split():String {
      return _split;
    }
  }
}
