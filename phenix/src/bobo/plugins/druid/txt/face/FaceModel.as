package bobo.plugins.druid.txt.face {
  import com.plugin.richTxt.IRichImgMapping;
  import com.util.img.ImageHelper;

  import flash.display.DisplayObject;

  public class FaceModel implements IRichImgMapping{



    private static var faceMap : Object = {};
    private static var groupMap : Object = {};
    private static var groups : Array = [];
    public var inited:Boolean = false;
    public function init() : void {
      for(var i : int = 0; i < FaceData.faces.length; i++){
        var faceInfo : FaceInfo = new FaceInfo(FaceData.faces[i]);
        faceMap[faceInfo.code] = faceInfo;
        var group : Array;
        if(groupMap.hasOwnProperty(faceInfo.group)){
          group = groupMap[faceInfo.group];
        }
        else {
          group = [];
          groupMap[faceInfo.group] = group;
          groups.push(faceInfo.group);
        }
        group.push(faceInfo);

      }
      inited = true;
    }

    public function getGroups() : Array {
      return groups;
    }

    public function getFaceInfosByGroup(group : String) : Array {
      return groupMap.hasOwnProperty(group) ? groupMap[group] : [];
    }

    public function getCover(group : String) : String {
      return FaceData.covers[group];
    }

    public function needVip(group : String) : Boolean {
      return FaceData.vip[group];
    }

    public static function isBase(group : String) : Boolean {
      return group == "emoji";
    }

    public static function getFaceInfoByCode(code : String) : FaceInfo {
      return faceMap[code];
    }


    public function getDisplayObj(id:String):DisplayObject {
      var result:DisplayObject;
      var info:FaceInfo = getFaceInfoByCode(id);
      result = ImageHelper.instance.getImageBitMap(info.thumb,info.width,info.height);
      return result;
    }

    public function getId(content:String):String {
      return "";
    }
  }
}
