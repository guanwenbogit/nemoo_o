package com.util.launcher {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import flash.system.ApplicationDomain;

	/**
	 * @author wbguan
	 */
	public class LaunchManager {
		protected static const INSIDE_EVENT:String = "INSIDE_EVENT";
		private var _launcherBuffer : Array = new Array();
		private var _step : int = 0;
		private var _currentStep : int = 0;
		private var _allReport : Object = new Object();
		private var _prepareAssets : Array = new Array();
		private var _maxLoaderCount : int = 5;
		private var _multipleProgress : Array = new Array();
		private var _isRunning : Boolean = false;
		private var _waitQueue : Array = new Array();
		private var _dispatcher : EventDispatcher;

		public function get step() : int {
			return _step;
		}

		public function LaunchManager() {
			this._dispatcher = new EventDispatcher();
		}

		public function init() : void {
		}

		private function loadMu() : void {
			var asset : Object = _prepareAssets.shift();
			if (asset != null) {
				var loader : AssetLoader = new AssetLoader(asset["url"], asset["name"], false, ApplicationDomain.currentDomain);
				loader.addEventListener(AssetEvent.COMPLETE_EVENT, onMutipleComplete);
				loader.addEventListener(AssetEvent.ERROR_EVENT, onMutipleError);
				loader.load();
				this._isRunning = true;
			}
		}

		public function prepare(assets : Array, maxThread : int = 1) : void {
			if (this._isRunning) {
				_waitQueue.push({assets:assets, thread:maxThread});
				return;
			}
			this._maxLoaderCount = maxThread;
			this._step = assets.length;
			this._currentStep = 0;
			for each (var asset : Object in assets) {
				this._prepareAssets.push(asset);
			}
			if (this._prepareAssets.length > 0) {
				for (var i : int = 0; i < this._maxLoaderCount; i++) {
					loadMu();
				}
			} else {
				this._isRunning = false;
			}
		}

		private function onMutipleError(event : AssetEvent) : void {
			if (event.data.isRetry) {
				errorReport(event);
				this.loadMu();
			} else {
				trace("[LaunchManager/onMutipleError] : reload url :" + event.url);
				var loader : AssetLoader = new AssetLoader(event.url, event.name, true, ApplicationDomain.currentDomain);
				loader.addEventListener(AssetEvent.COMPLETE_EVENT, onMutipleComplete);
				loader.addEventListener(AssetEvent.ERROR_EVENT, onMutipleError);
				loader.load();
			}
		}

		private function errorReport(event : AssetEvent) : void {
			trace("[LaunchManager/errorReport] " + " loader asset error : " + event.name + " url : " + event.url);
			this._currentStep++;
			_allReport[event.url] = 0;
			this.dispatcher.dispatchEvent(new LauncherEvent(LauncherEvent.STEP_ERROR_EVENT,event.url));
			if (this._currentStep == this._step) {
				this.allComplete();
			}
		}

		private function onComplete(event : AssetEvent) : void {
			trace("[LaunchManager/onComplete] " + event.url);
			this._launcherBuffer.push(event.name);
			this._currentStep++;
			_allReport[event.url] = 1;
			this.dispatcher.dispatchEvent(new LauncherEvent(INSIDE_EVENT));
			if (this._currentStep == this._step) {
				this.allComplete();
			}
		}

		private function onMutipleComplete(event : AssetEvent) : void {
			this._multipleProgress.push(event.url);
			onComplete(event);
			loadMu();
		}

		private function allComplete() : void {
			this._isRunning = false;
			if (this._waitQueue.length > 0) {
				var param : Object = this._waitQueue.shift();
				this.prepare(param["assets"], param["thread"]);
			} else {
				trace("[LaunchManager/allComplete]");
//				ExternalInterface.call("console.info", "[LaunchManager/allComplete] !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
				this.dispatcher.dispatchEvent(new LauncherEvent(LauncherEvent.LAUNCH_COMPLETE_EVENT,JSON.stringify(this._allReport)));
			}
		}

		private function onInside(event:Event = null) : void {
			while (this._launcherBuffer.length > 0) {
				var name : String = this._launcherBuffer.shift();
				this.dispatcher.dispatchEvent(new LauncherEvent(LauncherEvent.SETUP_EVENT,name));
			}
		}

		public function setup() : void {
			this.onInside();
			this.dispatcher.addEventListener(INSIDE_EVENT, onInside);
		}

		public function get dispatcher() : EventDispatcher {
			return _dispatcher;
		}

		public function dispose():void {

		}
	}
}
