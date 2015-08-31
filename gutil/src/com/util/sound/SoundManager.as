/**
 * Created by wbguan on 2015/3/6.
 */
package com.util.sound {
  import flash.display.Loader;
  import flash.events.Event;

  import flash.media.Sound;
  import flash.media.SoundChannel;

  import com.util.SimpleLoader;
  import com.util.reflect.ReflectionUtil;

  public class SoundManager {
    protected static var _instance:SoundManager;
    protected var _sounds:Object = {};
    private var _isPlaying:Boolean = false;
    private var _chanels:Array = [];
    private var _enable:Boolean = false;
    private var _loaded:Boolean =false;
    private var _loader:SimpleLoader = new SimpleLoader();
    private var _funcs:Object = {};

    public static function get instance():SoundManager{
      if(_instance == null){
        _instance = new SoundManager();
      }
      return _instance;
    }
    public function loadSound(url:String):void{
      _loader.load(url,onLoaded)
    }

    private function onLoaded(loader:Loader):void {
      this._loaded = true;

    }

    public function play(name:String):void{
      //playSound(name);
      playAndComplete(name, function():void{
        trace("Hall Music End");
        playSound(name);
      });
    }
    public function playSound(name:String):SoundChannel{
      var result:SoundChannel;
      if(this._enable&&_loaded) {
        var sound:Sound = this._sounds[name];
        if (sound == null) {
          sound = ReflectionUtil.getObj(name) as Sound;
          this._sounds[name] = sound;
        }
        if (sound != null) {
          var chanel:SoundChannel = sound.play();
          _isPlaying = true;
          chanel.addEventListener(Event.SOUND_COMPLETE,onPlayComplete);
          result = chanel;
          _chanels.push(chanel);
        }
      }else{
        trace("SoundManager : enable - " + this._enable + " | loaded -" + this._loaded);
      }
      return result;
    }
    /*
    *  func()
    * */
    public function playAndComplete(name:String,func:Function):void{
      var chanel:SoundChannel = this.playSound(name);
      if(chanel!=null){
        _funcs[chanel] = func;
      }else{
        if(func != null){
          func();
        }
        trace("SoundManager :" + this._enable + " | " + this._loaded);
      }
    }
    private function onPlayComplete(event:Event):void {
      var target:SoundChannel = event.target as SoundChannel;
      target.removeEventListener(Event.SOUND_COMPLETE,onPlayComplete);
      var func:Function = this._funcs[target];
      _isPlaying = false;
      var index:int = this._chanels.indexOf(target)
      if(index>=0){
        this._chanels.splice(index,1);
      }
      if(func != null){
        this._funcs[target] = null;
        delete this._funcs[target];
        func();
      }
    }

    public function checkAndPlay(name:String):void{
      if(!_isPlaying){
        this.playSound(name);
      }else{
        trace("SoundManager : enable - " + this._enable + " | loaded -" + this._loaded + " | playing - "+_isPlaying);
      }
    }
    public function stopAll():void{
      while(this._chanels.length>0){
        var channel:SoundChannel = this._chanels.pop();
        channel.stop();
      }
    }
    public function SoundManager() {

    }

    public function get enable():Boolean {
      return _enable;
    }

    public function set enable(value:Boolean):void {
      _enable = value;
    }

    public function hide():void {
      _loader.dispose();
      for(var key:String  in _sounds){
        _sounds[key] =null;
      }
      _instance = null;
    }
  }
}
