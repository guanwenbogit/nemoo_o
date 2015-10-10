package bobo.util {
  /**
   * @author wbguan
   */
  public class PropretiesFilter extends Object {
    public function PropretiesFilter() {
    }
    public static function includefilter(source:Array,key:String,value:Object):void{
      var len:int = source.length;
      for(var i:int=0 ; i <len;i++){
        var obj:Object = source[i];
        if(obj[key] != value){
          source.splice(i,1);  
          len = source.length;
          i--;
        }
      }
    }
    public static function excludefilter(source:Array,key:String,value:Object):void{
      var len:int = source.length;
      for(var i:int=0 ; i <len;i++){
        var obj:Object = source[i];
        if(obj[key] == value){
          source.splice(i,1);  
          len = source.length;
          i--;
        }
      }
    }
    public static function includeFilter(source:Vector.<Object>,key:String,value:Object):Vector.<Object> {
      var result:Vector.<Object> = new Vector.<Object>();
      for each(var obj:Object in source){
        if(obj[key] == value){
          result.push(obj);
        }
      }
      return result;
    }
    public static function excludeFilter(source:Vector.<Object>,key:String,value:Object):Vector.<Object> {
      var result:Vector.<Object> = new Vector.<Object>();
      for each(var obj:Object in source){
        if(obj[key] != value){
          result.push(obj);
        }
      }
      return result;
    }
    public static function hasAttribute(target:int,source:int):Boolean{
      var result:Boolean = false;
      if(target != 0  && (target == 1 || target%2 == 0)){
        var tmp:int = int(source/target)%2;
        result = (tmp != 0);
      }
      return result;
    }
  }
}
