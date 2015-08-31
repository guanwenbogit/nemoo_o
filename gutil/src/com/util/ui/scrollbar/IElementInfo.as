package com.util.ui.scrollbar {
	/**
	 * @author wbguan
	 */
  public interface IElementInfo {
		//----------------------------------
		//  x
		//----------------------------------
		function get ox():int 
		//----------------------------------
		//  y
		//----------------------------------
	    function get oy():int 
		//----------------------------------
		//  w
		//----------------------------------
	    function get w():int 
		//----------------------------------
		//  h
		//----------------------------------
		function get h():int

    function set ox(x : int) : void 
		function set oy(y : int) : void 
    function clone():IElementInfo;
    //----------------------------------
    //  active
    //----------------------------------
    function get active():Boolean ;
    function set active(value:Boolean):void 
    function dispose():void;

    function setIndex(i:int):void;
	}
}
