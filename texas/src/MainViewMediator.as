/**
 * Created by wbguan on 2015/7/30.
 */
package {
import org.robotlegs.mvcs.StarlingMediator;

import starling.events.Event;

public class MainViewMediator extends StarlingMediator {
    [Inject]
    public var view:MainView;

    override public function preRegister():void {
        super.preRegister();
        trace("MainViewMediator preRegister" +this.view);
    }

    public function MainViewMediator() {
        super();
    }

}
}
