package util.superMarquee {
  /**
   * @author wbguan
   */
  public class SuperMarqueeRender extends Object {
    private var _dis:Vector.<Item>;
    public function SuperMarqueeRender() {
    }
    public function setDisplays(params:Vector.<Item>):void {
      this._dis = params;
    }
    public function render(delay:int = 1):void{
      for each(var item:Item in this._dis){
        if(item.v.x != 0 || item.v.y != 0){
          item.x = item.x + item.v.x * delay;
          item.y = item.y + item.v.y * delay;
        }
      }
    }
    
  }
}
