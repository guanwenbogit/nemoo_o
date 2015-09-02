package bobo.modules.video.player
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class StatAdapter
	{
		private static var statAdapter:StatAdapter = new StatAdapter();
		private var uuid:String = "";
		private const statUrl:String = "http://stat.ws.126.net/bobo"; //统计地址
		
		public function StatAdapter()
		{
			uuid = generateUuid();
		}
		
		public static function get instance():StatAdapter
		{
			return statAdapter;
		}
		
		private function generateUuid():String
		{
			var ran:Number;
			var number:Number;
			var code:String;
			var checkCode:String = (new Date()).time.toString();
			for (var i:int = 0; i < 6; i++)
			{
				ran = Math.random();
				number = Math.round(ran * 1000);
				if (number % 2 === 0)
					code = String.fromCharCode(48 + (number % 10)); //如果是2的倍数则生成一个数字，0的ASCII码是48  
				else
					code = String.fromCharCode(65 + (number % 26));
				
				checkCode += code;
			}
			return checkCode;
		}
		
		private function send(params:Object):void
		{
			var loader:URLLoader = new URLLoader();
			var request:URLRequest = new URLRequest(statUrl);
			request.method = URLRequestMethod.POST;
			var variables:URLVariables = new URLVariables();
			
			variables["uuid"] = uuid;
			variables["channel"] = "bobo";
			variables["r"] = (new Date()).time;
			
			for (var key:Object in params)variables[key] = params[key];

			request.data = variables;
			
			loader.addEventListener(Event.COMPLETE, completeHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, errorHandler);
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(request);
		}
		
		private function completeHandler(e:Event):void
		{
		}
		
		private function errorHandler(e:*):void
		{
		}
		
		/**
		 *
		 * @param ontime
		 * @param roomID 房间ID
		 * @param fileID 主播ID
		 *
		 */
		public function buffer(ontime:String, roomID:String, fileID:String):void
		{
			var params:Object = {};
			params["act"] = 1;
			params["ontime"] = ontime;
			params["roomID"] = roomID;
			params["fileID"] = fileID;
			send(params);
		}
		
		public function heartbeat(ontime:String, roomID:String, fileID:String, sp:String):void
		{
			var params:Object = {};
			params["act"] = 0;
			params["ontime"] = ontime;
			params["roomID"] = roomID;
			params["fileID"] = fileID;
			params["sp"] = sp;
			send(params);
		}
		
		public function videoFailed(failurl:String, roomID:String, fileID:String):void
		{
			var params:Object = {};
			params["act"] = 3;
			params["roomID"] = roomID;
			params["fileID"] = fileID;
			params["failurl"] = failurl;
			send(params);
		}
		
		public function videoSuccess(successurl:String, roomID:String, fileID:String):void
		{
			var params:Object = {};
			params["act"] = 2;
			params["roomID"] = roomID;
			params["fileID"] = fileID;
			params["successurl"] = successurl;
			send(params);
		}
		
	}
}