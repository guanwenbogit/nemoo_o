/**
 * Created by wbguan on 2015/4/27.
 */
package com.plugin.richTxt {

  import flash.text.TextFormat;

  public class RichElement implements IRichElement {
    private var _type:String = "";
    private var _content:Object = "";
    private var _id:String = "";
    private var _tf:TextFormat;
    public function RichElement() {
    }

    public function get type():String {
      return _type;
    }

    public function get content():Object {
      return _content;
    }

    public function get id():String {
      return _id;
    }

    public function set type(value:String):void {
      _type = value;
    }

    public function set content(value:Object):void {
      _content = value;
    }

    public function set id(value:String):void {
      _id = value;
    }

    public function set tf(value:TextFormat):void {
      _tf = value;
    }

    public function get tf():TextFormat {
      return _tf;
    }
  }
}
