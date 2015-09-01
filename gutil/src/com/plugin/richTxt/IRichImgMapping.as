/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {
  import flash.display.DisplayObject;

  public interface IRichImgMapping {
    function getDisplayObj(id:String):DisplayObject;
    function getId(content:String):String;
  }
}
