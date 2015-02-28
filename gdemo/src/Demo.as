package {

    import animation.tool.grid.GridTool;

    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.text.TextField;

    import mk.MKDemo;

    import tower.TowerDemo;

    public class Demo extends Sprite {
    public function Demo() {
        this.stage.scaleMode = StageScaleMode.NO_SCALE;
        stage.align = StageAlign.TOP_LEFT;
        this.addChild(new TowerDemo());
//        var textField:TextField = new TextField();
//        textField.text = "";
////        addChild(new MKDemo());
////        addChild(textField);
//        addChild(new GridTool());
    }
}
}
