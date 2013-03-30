package org.libra.utils.encrypt {
	import flash.utils.ByteArray;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class UrlMultiEncode {
		
		public function UrlMultiEncode() {
			
		}
		public static function UrlEncode(str:String,encoder:String="utf8"):String { 
			var result:String = "";
			for (var i:int = 0; i < str.length ; i++)
			{
				var char:String = str.charAt(i);
				var bytes:ByteArray = new ByteArray();
			    bytes.writeMultiByte(char, encoder);
				if (char == " "||char=="\b")
				{
				     result += "+";
				}
				else if (char == "\n")
				{
				     result += "%0A";
				}
				else if (char == "+")
				{
				     result += "%2b";
				}
				else if (bytes.length == 1)
				{
				   result += char;
				}
				else 
				{
				   for (var j:int = 0; j < bytes.length; j++)
				   {
					   var tbyte:int = bytes[j] as int ;
					   var cstr:String= tbyte.toString(16);
					   result += "%" + cstr;
				   }
				}
			}
			return result;
		}
		
		public static function urlencodeGB2312(str:String):String { 
			var result:String = "";
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, "gb2312");
			for (var i:int; i < byte.length; i += 1) { 
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
		
		public static function urlencodeBIG5(str:String):String{
			var result:String = "";
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, "big5");
			for (var i:int; i < byte.length; i+= 1) { 
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
		
		public static function urlencodeGBK(str:String):String{
			var result:String = "";
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, "gbk");
			for (var i:int; i < byte.length; i += 1) { 
				result += escape(String.fromCharCode(byte));
			}
			return result;
		}
	}

}