package {

    import animation.tool.grid.GridTool;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.text.TextField;

    import icon.IconDemo;

    import imgRect.ImgRectTool;

    import imgUI.LR9BitmapDemo;

    import imgUI.NDemo;

    import mk.MKDemo;

    import tower.TowerDemo;

    public class Demo extends Sprite {
    public function Demo() {
        this.stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
//        this.addChild(new IconDemo());
//        this.addChild(new ImgRectTool());
//        var textField:TextField = new TextField();
//        textField.text = "";
////        addChild(new MKDemo());
////        addChild(textField);
//        addChild(new GridTool());
        this.addChild(new NDemo());
//        this.addChild(new LR9BitmapDemo());
    }
}
}
