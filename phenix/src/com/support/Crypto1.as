package com.support {
  import com.hurlant.crypto.hash.IHash;
  import com.hurlant.crypto.Crypto;
  import flash.utils.ByteArray;
  import com.hurlant.util.Hex;
  /**
   * @author sytang
   */
  public class Crypto1 {
    public static function c(input:String):String {
      var result:String;
      var ba:ByteArray = new ByteArray();
      
      for (var i:int = 0; i < input.length; i++) {
        ba.writeByte(input.charCodeAt(i));
      }
      
      ba.position = 0;
//      for (i = 0; i < ba.length; i++) {
//        //trace(ba.readByte());
//      }
      
      var md5:IHash = Crypto.getHash("md5");
      
      
      for (i = 0; i < 10; i++) {
        ba = md5.hash(ba);
        trace(Hex.fromArray(ba));
      }
      
      var str1:String = "";
      ba.position = 0;
//      for (i = 0; i < ba.length; i++) {
//        trace(ba.readByte());
//        //str1 = str1.concat(String.fromCharCode(ba.readByte()));
//      }

      
      var str:String = Hex.fromArray(ba) + "#live_@bobo@_163#";
      var hash:IHash = Crypto.getHash("sha256");
      ba = Hex.toArray(str);
      for (i = 0; i < 10; i++) {
        ba = hash.hash(ba);
      }
      result = Hex.fromArray(ba);      
      return result;
    }
    
    public function c2(input:String, date:String, rand:String):String {
      var to:String = input + date + rand;
      var result:String = "";
      for (var i:int = 0; i < to.length; i++) {
        if (isPrime(i)) {
        } else {
          result += to.charAt(i);
        }
      }
      var ba:ByteArray = new ByteArray();
      for (i = 0; i < result.length; i++) {
        ba.writeByte(result.charCodeAt(i));
      }
      
      var md5:IHash = Crypto.getHash("md5");
      ba = md5.hash(ba);
      
      var r:String = Hex.fromArray(ba);
      return r;
    }
    
    
    private function isPrime(n:int):Boolean {
      if(n % 2 == 0) {
        return false;
      }
      var circle:int = Math.sqrt(n);
      for (var i:Number = 3; i <= circle; i += 2) {
        if (n % i == 0) {
          return false;
        }
      }
      return true;
    }
  }
}
