/**
 * Created by wbguan on 2015/5/26.
 */
package bobo.util {
  import flash.net.SharedObject;

  public class SO extends Object {
    protected var obj:SharedObject;
    public function init(id:String):void{
      obj = SharedObject.getLocal(id);
    }
    public  function getValue(key:String):Object{
      var result:Object;
      if(obj!=null){
        result = obj.data[key];
      }
      return result;
    }
    public  function setValue(key:String,value:Object):void{
      if(obj!=null){
        obj.data[key] = value;
      }
    }
    public  function save():void{
      if(obj!=null){
        obj.flush();
      }
    }
    public function log():void{
      if(obj!=null&&obj.data!=null){
        trace("SO "+JSON.stringify(obj.data))
      }
    }
  }
}
