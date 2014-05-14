package org.libra.utils.bytes
{
	import flash.utils.ByteArray;
	
	/**
	 * 输出ByteArray为16进制
	 */
	public final class Byte2Hex
	{
		public static function Trace(bytes:ByteArray):void {
			if (bytes == null) {
				return;
			}
			var length:int = getHexLen(bytes.length);
			length = length > 4 ? length : 4;
			//trace(getTitle(length));
			bytes.position = 0;
			for (var j:int = 0; bytes.bytesAvailable > 0; j += 16) {
				var line:String = fillHexLen(j, length) + " ";
				var str:String = "";
				for (var i:int = 0; i < 16; i++) {	
					if (bytes.bytesAvailable > 0) {
						var char:int = bytes.readByte() & 0xFF;
						line += fillHexLen(char, 2) + " ";
						str += String.fromCharCode(char);
					}else {
						line += ".. ";
					}
				}
				trace(line, "\t", str);
			}
		}
		
		private static function fillHexLen(num:int, length:int):String {
			var str:String = num.toString(16);
			var zeros:String = "";
			for (var i:int = 0; i < length - str.length; i++) {
				zeros += "0";
			}
			return zeros + str;
		}
		
		private static function getHexLen(length:int):int {
			var bit:int = 0x0F;
			for (var i:int = 1; i <= 8; i++) {
				bit = bit << i | bit;
				if (bit > length) {
					return i;
				}
			}
			return 8;
		}
		
		private static function getTitle(length:int):String {
			var title:String = "";
			for (var i:int = 0; i < length; i++) {
				title += " ";
			}
			return(title + " 00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15");
		}
	}
}