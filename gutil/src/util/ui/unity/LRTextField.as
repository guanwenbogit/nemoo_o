package util.ui.unity {
	import com.util.ui.Interface.IDispose;

	import flash.text.TextFormat;
	import flash.text.TextField;

	/**
	 * @author wbguan
	 */
	public class LRTextField extends TextField implements IDispose{
		public var margin:Number = 4.2;
		
		public function LRTextField() {
			
		}
		
		override public function get text() : String {
			return this.text;
		}
		
		override public function set text(value : String) : void {
			super.text = value;
			this.resetWH();
		}
		
		override public function get htmlText() : String {
			return this.htmlText;
		}
		
		override public function set htmlText(value : String) : void {
			super.htmlText = value;
			this.resetWH();
			
		}
		
		override public function setTextFormat(format : TextFormat, beginIndex : int = -1, endIndex : int = -1):void{
			super.setTextFormat(format,beginIndex,endIndex);
			this.resetWH();
		}
		
		protected function resetWH():void{
			this.width = this.textWidth + this.margin;
			this.height = this.textHeight + this.margin;
		}
		
		public function dispose():void{
		}
	}
}
