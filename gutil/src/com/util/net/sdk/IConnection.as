/**
 * Created by wbguan on 2015/5/5.
 */
package com.util.net.sdk {
  import flash.events.IEventDispatcher;

  public interface IConnection extends IEventDispatcher{
    function get connected():Boolean;
    function send(value:String):void;

    function login(url:String, s:String, i:int):void;
    function reconnect():void;
    function get ready():Boolean;
  }
}
