package bobo.modules.chat.face {
  public class FaceInfo {

    private var _id : int;
    private var _group : String;
    private var _vip : int;
    private var _cover : String;
    private var _code : String;
    private var _description : String;
    private var _thumb : String;
    private var _source : String;
    private var _width : int;
    private var _height : int;

    public function FaceInfo(source : Object) {
      _id = source["id"];
      _group = source["group"];
      _vip = source["vip"];
      _cover = source["cover"];
      _code = source["code"];
      _description = source["description"];
      _source = source["source"];
      _thumb = source["thumb"];
      _width = source["width"];
      _height = source["height"];
    }

    public function get id():int {
      return _id;
    }

    public function get group():String {
      return _group;
    }

    public function get vip():int {
      return _vip;
    }

    public function get cover():String {
      return _cover;
    }

    public function get code():String {
      return _code;
    }

    public function get description():String {
      return _description;
    }

    public function get thumb():String {
      return _thumb;
    }

    public function get source():String {
      return _source;
    }

    public function get width():int {
      return _width;
    }

    public function get height():int {
      return _height;
    }
  }
}
