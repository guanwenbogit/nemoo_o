/**
 * Created by wbguan on 2015/2/3.
 */
package animation.tool.grid {
  import animation.grid.Grid;
  import animation.grid.VertexProvider;

  import flash.display.Bitmap;
  import flash.display.BitmapData;
  import flash.display.Loader;
  import flash.display.LoaderInfo;

  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.FocusEvent;
  import flash.events.MouseEvent;
  import flash.geom.Point;
  import flash.net.FileFilter;
  import flash.net.FileReference;
  import flash.system.ApplicationDomain;
  import flash.system.LoaderContext;
  import flash.text.TextField;
  import flash.text.TextFieldType;

  import unity.LRButton;

  public class GridTool extends Sprite {
    private var _pngBtn:LRButton;
    private var _outputBtn:LRButton;
    private var _iconBtn:LRButton;
    private var _icon:Bitmap;
    private var _sizeTxt:TextField;

    private var _file:FileReference;
    private var _vertexProvider:VertexProvider;
    private var _grid:Grid;
    private var _total:int = 0;
    private var _column:int = 0;
    private var _size:int = 0;
    private var _bitmap:Bitmap;
    private var _holder:Sprite;
    private var _runBtn:LRButton;
    public function GridTool() {
      super();
      initInstance();
    }
    private function initInstance():void{
      _pngBtn = new LRButton("png");
      _outputBtn = new LRButton("output");
      _runBtn = new LRButton("run");
      _sizeTxt = new TextField();
      _sizeTxt.type = TextFieldType.INPUT;
      _sizeTxt.background = true;
      _sizeTxt.text = "size";
      _holder = new Sprite();
      _iconBtn = new LRButton("icon");
      _file = new FileReference();
      _pngBtn.addEventListener(MouseEvent.CLICK, onPng);
      _outputBtn.addEventListener(MouseEvent.CLICK, onOut);
      _iconBtn.addEventListener(MouseEvent.CLICK, onIcon);
      _runBtn.addEventListener(MouseEvent.CLICK, onRun);
      this._sizeTxt.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut );
      this._sizeTxt.addEventListener(FocusEvent.FOCUS_IN,onFocusIn );
      this._outputBtn.mouseEnabled = false;

      this.addChild(this._pngBtn);
      this.addChild(this._outputBtn);_outputBtn.x = 50;
      this.addChild(this._sizeTxt);this._sizeTxt.x = 250;
      this.addChild(this._iconBtn);this._iconBtn.x = 150
      this.addChild(this._runBtn);this._runBtn.x = 200;
      this.addChild(this._holder);this._holder.y = 100;
    }

    private function onRun(event:MouseEvent):void {
      while(this._holder.numChildren>0){
        this._holder.removeChildAt(0);
      }
      main();
    }

    private function onIcon(event:MouseEvent):void {
      var file:FileReference = new FileReference();
      file.addEventListener(Event.SELECT, onIconSelect);
      file.addEventListener(Event.COMPLETE, onIconComplete);
      file.browse();
    }

    private function onIconComplete(event:Event):void {
      var file:FileReference = event.target as FileReference;
      var loader:Loader = new Loader();
      loader.loadBytes(file.data, new LoaderContext(false, ApplicationDomain.currentDomain));
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onIconData);
    }

    private function onIconData(event:Event):void {
      var loader:LoaderInfo = event.target as LoaderInfo;
      this._icon =loader.content as Bitmap;
    }

    private function onIconSelect(event:Event):void {
      var file:FileReference = event.target as FileReference;
      file.load();
    }

    private function onFocusIn(event:FocusEvent):void {
      this._sizeTxt.text = "";
    }

    private function onFocusOut(event:FocusEvent):void {

    }
    private function main():void {
      this._size = int(this._sizeTxt.text);
      if(this._size > 0){
        _column =Math.ceil(this._bitmap.width / this._size);
        var row:int = Math.ceil(this._bitmap.height/this._size);
        this._total = this._column*row;
        this._grid = new Grid(this._total,this._column,this._size);
        this._vertexProvider = new VertexProvider(this._bitmap,this._grid);
        this._holder.addChild(this._vertexProvider);

        for (var i:int = 0; i < this._vertexProvider.vertex.length; i++) {
          var vertext:Object = this._vertexProvider.vertex[i];
          var index:int = vertext["index"];
          var point:Point = _grid.getLocationByIndex(index);
          var bit:Bitmap = new  Bitmap();
          bit.bitmapData = _icon.bitmapData;
          bit.x = point.x+vertext["offsetX"];
          bit.y = point.y+vertext["offsetY"];
          this._holder.addChild(bit);

        }
      }
    }
    private function onOut(event:MouseEvent):void {
      if(this._vertexProvider != null) {
        var obj:Object = {};
        obj["size"] = this._size;
        obj["column"] = this._column;
        obj["total"] = this._total;
        obj["file"] = _file.name;
        obj["vertex"] = this._vertexProvider.vertex;
        obj["length"] = this._vertexProvider.vertex.length;
        var file:FileReference = new FileReference();
        file.save(JSON.stringify(obj));
      }
    }

    private function onPng(event:MouseEvent):void {
      var filter:Array = [new FileFilter("png file","*.png")];
      _file.addEventListener(Event.SELECT, onSelected);
      _file.addEventListener(Event.COMPLETE, onFileComplete);
      _file.browse(filter);
    }

    private function onFileComplete(event:Event):void {
      var loader:Loader = new Loader();
      loader.loadBytes(_file.data, new LoaderContext(false, ApplicationDomain.currentDomain));
      loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
    }

    private function onComplete(event:Event):void {
      var loader:LoaderInfo = event.target as LoaderInfo;
      this._bitmap =loader.content as Bitmap;
      this._outputBtn.mouseEnabled = true;
    }

    private function onSelected(event:Event):void {
      trace("[CarTool/onSelected] " + _file.name);
      _file.load();
      this._outputBtn.mouseEnabled = false;
    }
  }
}
