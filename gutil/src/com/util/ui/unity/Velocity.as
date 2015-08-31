package com.util.ui.unity {
  import flash.geom.Vector3D;
  /**
   * @author wbguan
   */
  public class Velocity extends Object {
    private var _vec:Vector3D;
    public function Velocity(x:int,y:int) {
      _vec = new Vector3D(x,y);
    }
    public function get x():int{
     return int(_vec.x); 
    }
    public function set x(x:int):void {
      _vec.x = x;
    }
    public function get y():int{
     return int(_vec.y); 
    }
    public function set y(y:int):void {
      _vec.y = y;
    }
    public function setZero():void {
      this._vec.x = this._vec.y = 0;
    }
  }
}
