/**
 * Created by wbguan on 2015/4/28.
 */
package com.util.layer {
  import flash.display.DisplayObject;
  import flash.display.DisplayObjectContainer;

  public class LayerBak extends Object {
    private var _keys:Vector.<String> = new <String>[];
    private var _map:Object = {};
    private static var layer:LayerBak = new LayerBak();
    public function LayerBak() {
      super();
      if(layer)
        throw new Error("Use getInstance()");
    }

    public static function getInstance():LayerBak
    {
      return layer;
    }

    public function add(name:String,container:DisplayObjectContainer):void{
      if(_keys.indexOf(name)<0){
        _map[name] = container;
        _keys.push(name);
      }else{
        throw new Error("Existed container name");
      }
    }

    public function getContainer(name:String):DisplayObjectContainer{
      var result:DisplayObjectContainer;
      result = _map[name];
      return result;
    }
    public function remove(name:String):DisplayObjectContainer{
      var result:DisplayObjectContainer;
      if(_keys.indexOf(name)>=0){
        _keys = _keys.splice(_keys.indexOf(name),1);
      }
      result = _map[name];
      return result;
    }

  }
}
