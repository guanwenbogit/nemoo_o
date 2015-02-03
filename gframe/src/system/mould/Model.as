/**
 * Created by wbguan on 2015/2/2.
 */
package system.mould {
  import system.api.IModel;


  public class Model implements IModel {
    private var _name:String = "";
    public function Model() {
    }

    public function update(obj:Object):void {
      if(obj != null){
        this.updateData();
      }
    }

    protected function updateData():void {

    }
    public function get name():String {
      return this.name;
    }

    public function set name(value:String):void {
      this._name = value;
    }
  }
}
