/**
 * Created by wbguan on 2015/7/28.
 */
package bobo.util {

  import com.util.reflect.ReflectionUtil;
  import com.util.ui.unity.LRButton;
  import com.util.ui.view.PreLoadingView;


  import flash.events.MouseEvent;



  public class DialogView extends PreLoadingView {

    private var _confirm:Function;
    private var _cancel:Function;
    protected var _content:String = "";
    protected var _confirmBtn:LRButton;
    protected var _cancelBtn:LRButton;
    public function DialogView(confirmBtn:LRButton,cancelBtn:LRButton) {
      _confirmBtn = confirmBtn;
      _cancelBtn = cancelBtn;
      super(ReflectionUtil.getDisplayObj(""),443,240);
    }

    override public function init():void {
      super.init();
      initInstance();
      setTxt();
      addToParent();
      initListener();
    }
    protected function initInstance():void{

    }
    protected function setTxt():void{

    }
    protected function addToParent():void{

    }

    protected function initListener():void{
      if(_confirmBtn!=null){
        _confirmBtn.addEventListener(MouseEvent.CLICK, onConfirm);
      }
      if(_cancelBtn!=null){
        _cancelBtn.addEventListener(MouseEvent.CLICK, onCancel);
      }
    }

    private function onCancel(event:MouseEvent):void {
      this.close();
      if(this._cancel !=null){
        _cancel();
        _cancel = null;
      }

    }

    private function onConfirm(event:MouseEvent):void {
      this.close();
      if(this._confirm !=null){
        _confirm();
        _confirm = null;
      }

    }

    public function dialog(content:String,confirm:Function,cancel:Function):void{
      _content = content;
      _confirm = confirm;
      _cancel = cancel;
    }

    public function close():void {
      if(this.parent!=null){
        this.parent.removeChild(this);
      }
      if(_confirmBtn!=null){
        _confirmBtn.removeEventListener(MouseEvent.CLICK, onConfirm);
      }
      if(_cancelBtn!=null){
        _cancelBtn.removeEventListener(MouseEvent.CLICK, onCancel);
      }
    }
  }
}
