/**
 * Created by wbguan on 2015/1/29.
 */
package system.mould {
  import system.api.IData;
  import system.api.IModel;
  import system.api.hub.HubPool;

  public class DataMould extends Mould implements IData {
    public function DataMould(hubPool:HubPool) {
      super(hubPool);
    }

    public function bindModel(model:IModel):void {
    }
  }
}
