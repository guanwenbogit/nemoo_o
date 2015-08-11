/**
 * Created by wbguan on 2015/7/30.
 */
package {
import org.robotlegs.mvcs.StarlingContext;

import starling.display.DisplayObjectContainer;

public class MainContext extends StarlingContext {
    public function MainContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
        super(contextView, autoStartup);
    }

    override public function startup():void {
        mediatorMap.mapView(MainView,MainViewMediator);
        super.startup();
    }
}
}
