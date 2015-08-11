/**
 * Created by wbguan on 2015/8/11.
 */
package model {
  public class PlaneObj extends MObject {
    [Embed(source= "plane.png.json",mimeType = "application/octet-stream")]
    private var PlaneJson:Class;
    private var json:Object;
    public function PlaneObj() {
      super();

    }
    override public function init(obj:Object):void {
      json = new PlaneJson();
      json = JSON.parse(json.toString());
      json["speed"] = obj["speed"];
      json["mass"] = obj["mass"];
      json["power"] = obj["power"];
      json["name"] = obj["name"];
      super.init(json);
    }
  }
}
