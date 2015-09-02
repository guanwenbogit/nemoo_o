package bobo.util.loader
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	
	public class LoadSwf extends EventDispatcher
	{
		private const loader:Loader = new Loader();
		private var request:URLRequest;
		private var swfLoader:DisplayObject;
		private var SWF_LOADED:String = "";
		private var NO_SWF:String = "";
		private var PROGRESS:String = "";
		private var bytesLoaded:Number;
		private var bytesTotal:Number;
		
		public function LoadSwf()
		{
		}
		
		public function loadSwf(_url:String, _successEvent:String, _failedEvent:String, _progressEvent:String):void
		{
			SWF_LOADED = _successEvent;
			NO_SWF = _failedEvent;
			PROGRESS = _progressEvent;
			
			configureListeners(loader.contentLoaderInfo);
			request = new URLRequest(_url);
			loader.load(request);
		}
		
		private function configureListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
		}
		
		private function completeHandler(event:Event):void
		{
			swfLoader = event.target.content;
			dispatchEvent(new Event(SWF_LOADED));
		}
		private function progressHandler(event:ProgressEvent):void
		{
			bytesLoaded = event.bytesLoaded;
			bytesTotal = event.bytesTotal;
			dispatchEvent(new Event(PROGRESS));
		}
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			dispatchEvent(new Event(NO_SWF));
		}
		private function securityErrorHandler(event:SecurityErrorEvent):void
		{
			dispatchEvent(new Event(NO_SWF));
		}
		
		public function close():void
		{
			loader.close();
		}
		
		public function get swf():DisplayObject
		{
			return swfLoader;
		}

		public function get pct():Number {
			return bytesLoaded/bytesTotal;
		}
	}
}