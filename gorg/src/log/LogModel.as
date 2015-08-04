/**
 * Created by wbguan on 2015/7/15.
 */
package log {
  public class LogModel {
    private static const MAX:int = 500;
    private var _buffer:Vector.<LogInfo> = new <LogInfo>[];
    public function LogModel() {
    }
    public function append(info:LogInfo):void{
      _buffer.push(info);
      while(_buffer.length>MAX){
        _buffer.pop();
      }
    }

    public function getLog(start:int,len:int = -1):Vector.<LogInfo>{
      var result:Vector.<LogInfo> = new <LogInfo>[];
      if(len<0){
        len = this._buffer.length - start;
      }
      if(start>=0&&(start+len)<=_buffer.length){
        result = _buffer.slice(start,len);
      }
      return result;
    }


    public function get buffer():Vector.<LogInfo> {
      return _buffer;
    }
  }
}
