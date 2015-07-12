package util.ui.scrollbar {
	import com.util.ui.shape.LRRectangle;

	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import flash.display.Sprite;


	/**
	 * @author wbguan
	 */
	public class LRScrollerElement extends Sprite implements IElementInfo {
		protected var data:Object;
		public function LRScrollerElement() {
		}
		public function setData(info:Object):void {
		  if(info != this.data){
		    this.data = info;
			  bind();
				resize();
		  }
		}
		protected function resize():void{
			this._h = this.height;
			this._w = this.width;
		}
		protected function bind():void{
			var bg:LRRectangle = new LRRectangle(100, int(this.data)%4 * 10+ 30,0x123456+int(this.data)*50);
			var txt:TextField = new TextField();
			txt.autoSize = TextFieldAutoSize.LEFT;
			txt.mouseEnabled = false;
			this.addChild(bg);
			this.addChild(txt);
      txt.text = int(this.data) + ":element" + " : h :" + this.height;
      this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
      this.addEventListener(MouseEvent.ROLL_OUT, onOut);
    }

    private function onOut(event:MouseEvent):void {
      this.alpha = 1;
    }

    private function onOver(event:MouseEvent):void {
      this.alpha = 0.9;
    }
		public function clear():void{
			while(this.numChildren > 0){
				this.removeChildAt(0);
			}
      _ox =_oy = _w = _h = 0;
		}
    public function init():void{
      
    }
		public function setIndex(i:int):void{
      
    }
		//----------------------------------
		//  x
		//----------------------------------
		private var _ox:int = 0;
		public function get ox():int {
		  return _ox;
		}
		//----------------------------------
		//  y
		//----------------------------------
		private var _oy:int = 0;
		public function get oy():int {
		  return _oy;
		}
		//----------------------------------
		//  w
		//----------------------------------
		private var _w:int = 0;
		public function get w():int {
      this._w = this.width;
		  return _w;
		}
		//----------------------------------
		//  h
		//----------------------------------
		private var _h:int = 0;
		public function get h():int{
      this._h = this.height;
		  return _h;
		}
    public function clone():IElementInfo {
      var result:LRScrollerElement;
      result = new LRScrollerElement();
      result.setData(this.data);
      return result;
    }
		public function set ox(x : int) : void {
			_ox = x;
		}

		public function set oy(y : int) : void {
			_oy = y;
		}
		public function dispose():void{
			this.clear();
    }
    //----------------------------------
    //  active
    //----------------------------------
    private var _active:Boolean;
    public function get active():Boolean {
      return _active;
    }
    public function set active(value:Boolean):void {
      _active = value;
    }
    public function ondrag():void {
    }
	}
}
