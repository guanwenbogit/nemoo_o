package com.util.ui.scrollbar {
	import flash.geom.Rectangle;
	import flash.geom.Point;
	/**
	 * @author wbguan
	 */
	public class LRScrollerPanelCore extends Object {
		private var displayPoint:Point = new Point();
		private var displayRect:Rectangle = new Rectangle();
		private var totalRect:Rectangle = new Rectangle();
		private var _infos:Vector.<IElementInfo> = new Vector.<IElementInfo>();
    private var _margin:int = 5;
		public function LRScrollerPanelCore(w:int,h:int,margin:int = 5) {
			displayRect.width = w;
			displayRect.height = h;
      this._margin = margin;
		}
		public function attachElements(infos:Vector.<IElementInfo>):void{
			this._infos = infos;
		}
		public function setHeight(h:int):void{
      h = h < 1? 1:h;
      displayRect.height = h;
    }
		public function setRect():void{
			var i:int = 0;
			this.totalRect.height = 0;
			for each(var info:IElementInfo in this._infos){
				if(i-1>=0){
					var prev:IElementInfo = this._infos[i-1];
					info.oy = prev.h + prev.oy + this._margin;
				}else{
		      info.oy = 0;
				}
				this.totalRect.height += (info.h + this._margin);
				if(info.w > this.totalRect.width){
					this.totalRect.width = info.w;
				}
				trace("[LRScrollerPanelCore/setRect] oy : " + info.oy);
				i++;
			}
			trace("[LRScrollerPanelCore/setRect] height : " + this.totalRect.height);
		}
		
		public function getSpan():int{
			var result:int = (totalRect.height - displayRect.height);
			return result;
		}
		public function getSpanScale():Number {
			var result:Number = 1;
			var span:int = this.getSpan();
			if( span > 0){
		      result = 1- Math.abs(span)/this.displayRect.height;
			}
			if(result < 0.2){
				result = 0.2;
			}
			return result;
		}
		public function setRate(rate:Number):void{
			var span:int = getSpan();
			if(span > 0){
				var offSet:int = Math.floor(span * rate);
				displayPoint.y = -offSet;
//				trace("[LRScrollerPanelCore/setRate] displayPoint.y : " + displayPoint.y);
			}else{
        displayPoint.y = 0;
      }
		}
    public function move(param:int):void{
			var span:int = getSpan();
			var tmp:int = Math.abs(param);
			tmp = tmp>span?span:tmp;
			if(param<0){
				tmp = -tmp;
			}
			if(span > 0){
				displayPoint.y += tmp;
			}else{
				displayPoint.y = 0;
			}
			if(displayPoint.y>0){
				displayPoint.y = 0;
			}
			if(displayPoint.y < -span){
				displayPoint.y = -span;
			}
		}
		public function getDisplayStartPoint():Point{
			return this.displayPoint;
		}
		
		public function getDisplayInfos(excepts:Vector.<IElementInfo> = null):Vector.<IElementInfo>{
			var result:Vector.<IElementInfo> = new Vector.<IElementInfo>();
			var i:int = 0;
			var start:int = -1;
			var end:int = -1;
			var endy:int = Math.abs(displayPoint.y) + displayRect.height;
			for each(var info:IElementInfo in this._infos){
				if(start < 0){
				  if(info.oy == Math.abs(displayPoint.y)){
					start = i;
				  }else if(info.oy > Math.abs(displayPoint.y)){
					start = i - 1;
				  }
				}
				if(end < 0){
					if(info.oy + info.h >= endy || i == this._infos.length - 1){
						end = i+1;
					}
				}else{
					break;
				}
				i++;
			}
//			trace("[LRScrollerPanelCore/getDisplayInfos] s|e :" +start + "|" +end);
      
			result = this._infos.slice(start,end);
      i = start;
      for each(info in result){
        info.setIndex(i);
        i++;
      }
			if(excepts != null){
				var temp:Vector.<IElementInfo> = new Vector.<IElementInfo>();
				if(start != 0){
				  temp = this._infos.slice(0,start);
				}
				if(end < this._infos.length){
				  temp = temp.concat(this._infos.slice(end));
				}
				for each(var e:IElementInfo in temp){
					excepts.push(e);
				}
			}
			return result;
    }

    public function getRate():Number {
      var result:Number = 0;
      var span:int = getSpan();
      if(span > 0){
        result = Math.abs(displayPoint.y)/span;
      }
      if(result < 0.1){
        result = 0.0;
      }
      return result;
    }

    public function dispose():void {
      while(this._infos.length > 0){
        var info:IElementInfo = this._infos.pop();
        info.dispose();
      }
    }
		public function getIndexUnderPoint(point:Point):int{
			var result:int = 0;
			for each(var element:IElementInfo in this._infos){
				if(element.oy + this.displayPoint.y +element.h >= point.y){
					break;
				}
				result++;
			}
			return result;
		}
		public function getDisplayLast():int{
      var point:Point = new Point(0,displayRect.height);
			return getIndexUnderPoint(point);
		}
		public function getDisplayFirst():int{
			var point:Point = new Point(0,0);
			return getIndexUnderPoint(point);
		}
	}
}
