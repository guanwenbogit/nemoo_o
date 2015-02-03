/**
 * Created by wbguan on 2015/1/22.
 */
package richtxt {
  public class Rich extends RichGraphics {
    public function Rich() {
      super();
    }

    override public function init():void {
      super.init();
      var g:GraphicsInfo = new GraphicsInfo();
      g.key = "u:smile";
      g.url = "http://imgsize.ph.126.net/?imgurl=http://img2.ph.126.net/BFoAFBS2_bPhMUKQIpXYxA==/1752181730123917925.jpg_250x60x0x85.jpg";
      g.w = 25;
      g.h = 25;
      var g1:GraphicsInfo = new GraphicsInfo();
      g1.key = "u:cry";
      g1.url = "http://imgsize.ph.126.net/?imgurl=http://img2.ph.126.net/BFoAFBS2_bPhMUKQIpXYxA==/1752181730123917925.jpg_250x60x0x85.jpg";
      g1.w = 25;
      g1.h = 25;
      this._ginfos.push(g1,g);
    }
  }
}
