package util.launcher {
	import flash.events.Event;

	/**
	 * @author wbguan
	 */
	public class LauncherEvent extends Event {

		public static const LAUNCH_COMPLETE_EVENT:String = "LAUNCH_COMPLETE_EVENT";
		public static const SETUP_EVENT:String = "SETUP_EVENT";
		public static const STEP_ERROR_EVENT:String = "STEP_ERROR_EVENT";
		public var param:String = "";
		public function LauncherEvent(type : String, param:String = "",bubbles : Boolean = true, cancelable : Boolean = false) {
			this.param = param;
			super(type, bubbles, cancelable);
		}
		override public function clone():Event{
			return new LauncherEvent(type, param,bubbles,cancelable);
		}
	}
}
