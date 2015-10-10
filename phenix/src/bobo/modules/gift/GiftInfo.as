package bobo.modules.gift {

  /**
   * @author sytang
   */
  public class GiftInfo extends Object {
    
    public static const FLV_EFFECT:int = 100000;
    public static const MAX_GIFT_NUM : int = 9999;
    //----------------------------------
    //  name
    //----------------------------------
    private var _name:String;
    private var _feature:int;
    public function get name():String {
      return _name;
    }
    //----------------------------------
    //  id
    //----------------------------------
    private var _id:int;
    public function get id():int {
      return _id;
    }
    //----------------------------------
    //  price
    //----------------------------------
    private var _price:int;
    public function get price():int {
      return _price;
    }
    //----------------------------------
    //  type
    //----------------------------------
    private var _type:int;
    public function get type():int {
      return _type;
    }
    //----------------------------------
    //  resourceId
    //----------------------------------
    private var _resourceId:String;
    public function get resourceId():String {
      return _resourceId;
    }
    //----------------------------------
    //  giftGroup
    //----------------------------------
    private var _giftGroup:String;
    public function get giftGroup():String {
      return _giftGroup;
    }
    //----------------------------------
    //  effect
    //----------------------------------
//    private var _effect:int;
//    public function get effect():int {
//      return _effect;
//    }
    private var _effectType:int = 0;
    public function hasEffect() : Boolean {
      return _effectType > 0;
    }
    
    public function hasFlvEffect() : Boolean {
      return _effectType > 1;
    }
    
    
    
    //----------------------------------
    //  effectUrl
    //----------------------------------
    private var _effectUrl : String;
    public function get effectUrl() : String {
      return _effectUrl;
    }
    
    private var _effectClassName : String = "";
    public function getEffectClassName() : String {
      return _effectClassName;
    }
    
    //----------------------------------
    //  starBadgeUrl
    //----------------------------------
    private var _starBadgeUrl : String;
    public function get starBadgeUrl() : String {
      return _starBadgeUrl;
    }
    //----------------------------------
    //  isHide
    //----------------------------------
    private var _isHide:Boolean = false;
    public function get isHide():Boolean {
      return _isHide;
    }
    //----------------------------------
    //  isWeekStar
    //----------------------------------
    private var _isWeekStar:Boolean;
    public function get isWeekStar():Boolean {
      return _isWeekStar;
    }
    //----------------------------------
    //  cornerMark
    //----------------------------------
    private var _cornerMark:int;
    public function get cornerMark():int {
      return _cornerMark;
    }
    //----------------------------------
    //  forbidToUser
    //----------------------------------
    private var _forbidToUser:Boolean = false;
    public function get forbidToUser():Boolean {
      return _forbidToUser;
    }
    //----------------------------------
    //  tipsUrl
    //----------------------------------
    private var _tipsUrl:String;
    public function get tipsUrl():String {
      return _tipsUrl;
    }
    //----------------------------------
    //  index
    //----------------------------------
    private var _index:int = 0;
    public function get index():int{
      return _index;
    }
    private var _imageUrl:String = "";
    public function set index(value:int):void {
      _index = value;
    }
    //----------------------------------
    //  _roomShowType
    //----------------------------------
    private var _roomShowType:int;
    public function get roomShowType():int {
      return _roomShowType;
    }

    //----------------------------------
    //  description
    //----------------------------------
    private var _description:String = "";
    public function get description():String {
      return _description;
    }
    //----------------------------------
    //  previousWeekStar
    //----------------------------------
    private var _previousWeekStar:Boolean;
    public function get previousWeekStar():Boolean {
      return _previousWeekStar;
    }

    //----------------------------------
    //  bindToRoom
    //----------------------------------
    private var _bindToRoom:int;
    public function get bindToRoom():int {
      return _bindToRoom;
    }

    private var giftPackage:Array = [];
    public function GiftInfo(source:Object) {
      if (!source) {
        _name = "";
        _id = 1;
      } else {        
        _name = source["name"];
        _resourceId = source["image"] || "GIFT_LOLIPOP";
        _resourceId = _resourceId.toUpperCase();
        _id = source["giftId"];
        _price = source["price"];
        _type = source["type"];
        _giftGroup = source["giftGroup"];
//        _effect = source["effect"];
        _isWeekStar = int(source["star"]) == 1;
        if(source["status"] == 0 || !source["show"]){
          _isHide = true;
        }
        _feature = source["feature"] ;
        _imageUrl = source["imageUrl"];
        _effectUrl = source["effectUrl"] || "";
        _starBadgeUrl = source["starBadgeUrl"] || "";
        _cornerMark = source["cornerMark"] || 0;
        _forbidToUser = source["forbidToUser"];
        _tipsUrl = source["tipsUrl"] || null;
        _roomShowType = source["roomShowType"];
        _bindToRoom = source["bindToRoom"] || 0;

        this.giftPackage =  source["giftPackageList"] as Array;
//        this._package = [{id:6,num:50},{id:12,num:100}];
        if(_effectUrl != ""){
          var arr : Array = _effectUrl.substring(_effectUrl.lastIndexOf("/") + 1).split(".");
          _effectClassName = arr[0];
          var extension : String = arr[1];
          _effectType = (extension == "swf" ? 1 : 2);
        }
        _previousWeekStar = source["previousWeekStar"];
        _description = source["description"] || "";
      }
        //_resourceId = "GIFT_LOLIPOP";
    }
    public function isVip():Boolean {
      return _type == 1;
    }
    public function isPackage():Boolean {
      return _type == 2;
    }

    public function set isHide(newIsHide:Boolean):void {
      _isHide = newIsHide;
    }
    public function isBoquan():Boolean {
      return _type == 11;
    }
    public function get feature():int {
      return _feature;
    }

    public function get imageUrl():String {
      return _imageUrl;
    }
    
//    public function getCornerMarkUIName() : String {
//      if(_isWeekStar){
//        return UINames.GIFT_STAR;
//      }
//      var result : String = "";
//      switch(_cornerMark){
//        case 1:
//          result = UINames.GIFT_LABEL;
//          break;
//        case 2:
//          result = UINames.GIFT_LUCKY;
//          break;
//        case 3:
//          result = UINames.GIFT_QUAN;
//          break;
//        case 4:
//          result = UINames.GIFT_SOUND;
//          break;
//        case 5:
//          result = UINames.GIFT_SHOW;
//          break;
//      }
//      return result;
//    }
    public function isAllIn():Boolean{
      return type == 12;
    }
    public function isPak():Boolean{
      return (this.giftPackage!= null && this.giftPackage.length > 0);
    }
    public function get packageArr():Array{
      return this.giftPackage;
    }
  }
}
