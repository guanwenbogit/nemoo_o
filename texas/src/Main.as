package {
  import starling.display.Sprite;

  import sys.state.Machine;

  public class Main extends Sprite {
    private var machine:Machine;
    public function Main() {
      initInstance();
    }
    private function initInstance():void{
      machine = new Machine();
    }
  }
}
