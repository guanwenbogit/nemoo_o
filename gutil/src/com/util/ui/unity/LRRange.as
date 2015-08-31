package com.util.ui.unity {
  /**
   * @author wbguan
   */
  public class LRRange extends Object {
    public static const UP : String = "up";
    public static const DOWN : String = "down";
    public static const LEFT : String = "left";
    public static const RIGHT : String = "right";
    private var _xy : String;
    private var _wh : String;
    private var _dir : int;
    // ----------------------------------
    // margin
    // ----------------------------------
    protected var _margin : Number;

    public function get margin() : Number {
      return _margin;
    }

    public function set margin(value : Number) : void {
      _margin = value;
    }

    // ----------------------------------
    // direction
    // ----------------------------------
    protected var _direction : String;

    public function get direction() : String {
      return _direction;
    }
    public function LRRange() {
    }
  }
}
