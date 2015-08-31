package com.util.net.http {
  import flash.events.SecurityErrorEvent;
  import flash.net.URLRequestHeader;
  import flash.net.URLRequestMethod;
  import flash.events.IOErrorEvent;
  import flash.events.Event;
  import flash.net.URLVariables;
  import flash.net.URLRequest;
  import flash.net.URLLoader;
  /**
   * @author sytang
   */
  public class HTTPCall {
    //==========================================================================
    //  Constructor
    //==========================================================================
    private var requesting:Boolean = false;
    private var _callBack:Function;

    public function HTTPCall(url:String, data:Object, cookie:String = null) {
      urlLoader = new URLLoader();
      request.url = url;
      var requestData:URLVariables = new URLVariables();
      if (data) {
        requestData.data = JSON.stringify(data);
      } else {
        requestData.data = '';
      }
      request.data = requestData;
      if (cookie) {
        var header:URLRequestHeader = new URLRequestHeader();
      }
      request.method = URLRequestMethod.POST;
    }

    public function load(callBack:Function):void{
      if(!requesting){
        addListeners();
        urlLoader.load(request);
        requesting = true;
        _callBack = callBack;
      }else{
        trace("Waiting : "+request.url);
      }
    }
    //==========================================================================
    //  Variables
    //==========================================================================
    private var urlLoader:URLLoader;
    private var request:URLRequest = new URLRequest();
    //==========================================================================
    //  Private methods
    //==========================================================================
    private function removeListeners():void {
      urlLoader.removeEventListener(Event.COMPLETE, completeHandler);
      urlLoader.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
    }
    private function addListeners():void {
      urlLoader.addEventListener(Event.COMPLETE, completeHandler);
      urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
      urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
    }

    private function securityErrorHandler(event:SecurityErrorEvent):void {
      removeListeners();
      call(event.text,2);
    }
    //==========================================================================
    //  Event handlers
    //==========================================================================
    private function ioErrorHandler(event:IOErrorEvent):void {
      removeListeners();
      call(event.text,1);
    }
    private function completeHandler(event:Event):void {
      removeListeners();
      call(urlLoader.data,0);
    }

    private function call(data:Object,flag:int):void{
      if(_callBack != null){
        _callBack(data,flag);
      }
    }
    public function dispose():void{
      _callBack = null;
      urlLoader.close();
      urlLoader = null;
      request = null;
    }

  }
}
