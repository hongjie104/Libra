package org.libra.utils.text {
	import flash.utils.ByteArray;
	
	import org.libra.utils.encrypt.Base64;
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class StringUtil {
		
		/**
		 * replace oldString with newString in targetString
		 */
		public static function replace(targetString:String, oldString:String, newString:String):String {
			return targetString.split(oldString).join(newString);
		}
		
		/**
		 * remove the blankspaces of left and right in targetString
		 */
		public static function trim(targetString:String):String {
			return trimLeft(trimRight(targetString));
		}
		
		/**
		 * remove only the blankspace on targetString's left
		 */
		public static function trimLeft(targetString:String):String {
			var tempIndex:int = 0;
			var tempChar:String = "";
			for (var i:int = 0; i < targetString.length; i++){
				tempChar = targetString.charAt(i);
				if (tempChar != " "){
					tempIndex = i;
					break;
				}
			}
			return targetString.substr(tempIndex);
		}
		
		/**
		 * remove only the blankspace on targetString's right
		 */
		public static function trimRight(targetString:String):String {
			var tempIndex:int = targetString.length - 1;
			var tempChar:String = "";
			for (var i:int = targetString.length - 1; i >= 0; i--){
				tempChar = targetString.charAt(i);
				if (tempChar != " "){
					tempIndex = i;
					break;
				}
			}
			return targetString.substring(0, tempIndex + 1);
		}
		
		public static function getCharsArray(targetString:String, hasBlankSpace:Boolean):Array {
			var tempString:String = targetString;
			if (!hasBlankSpace){
				tempString = trim(targetString);
			}
			return tempString.split("");
		}
		
		public static function startsWith(targetString:String, subString:String):Boolean {
			return targetString.indexOf(subString) == 0;
		}
		
		public static function endsWith(targetString:String, subString:String):Boolean {
			return targetString.lastIndexOf(subString) == (targetString.length - subString.length);
		}
		
		public static function isLetter(chars:String):Boolean {
			if (chars == null || chars == ""){
				return false;
			}
			for (var i:int = 0; i < chars.length; i++){
				var code:uint = chars.charCodeAt(i);
				if (code < 65 || code > 122 || (code > 90 && code < 97)){
					return false;
				}
			}
			return true;
		}
		
		public static function unmarshalMsg(line:String):Array { 
			var vars:Array = line.split(" ");
			var l:int = vars.length;
			for (var i:int = 0; i < l; ++i){
				var ts:String = vars[i].toString();
				var ll:int = ts.length;
				if (ts.indexOf("\\") >= 0){
					var sb:String = "";
					for (var j:int = 0; j < ll; ++j){
						var ts1:String = ts.charAt(j);
						if (ts1 != "\\")
							sb += ts1;
						else {
							j++;
							var ts2:String = ts.charAt(j);
							switch (ts2){
								case "b": 
									sb += " ";
									break;
								case "n": 
									sb += "\n";
									break;
								case "\\": 
									sb += "\\";
									break;
								default: 
									sb += "";
							}
						}
					}
					vars[i] = sb;
				}
			}
			return vars;
		}
	
		/**
		 * 获得字符串所占字节数
		 * @param	str	要计算的字符串
		 * @param	isutf8	是否UTF8编码
		 */ 
		public static function getStrLen(str:String, isutf8:Boolean = true):int { 
			var len:int = 0;
			var l:int = str.length;
			for (var p:int = 0; p < l; p++) { 
				len += str.charCodeAt(p) > 255 ? (isutf8 ? 3 : 2) : 1;
			}
			return len;
		}
		
		/**
		 * 压缩
		 * @param	value
		 * @return
		 */
		public static function compress(value:String):String { 
			var textBytes:ByteArray = new ByteArray();
			textBytes.writeUTFBytes(value);
			textBytes.compress();
			return Base64.encodeByteArray(textBytes);
		}
		
		/**
		 * 解压缩
		 * @param	value
		 * @return
		 */
		public static function unCompress(value:String):String{
			var textBytes:ByteArray = Base64.decodeToByteArray(value);
			textBytes.uncompress();
			return textBytes.toString();
		}
		
		/**
		 
		 */
		public static function sortByPinYin(arr:Vector.<String>):Vector.<String> {
//			var byte:ByteArray = new ByteArray();
//			var sortedArr:Array = [];
//			var returnArr:Vector.<String> = new Vector.<String>();
//			for each(var str:String in arr) {
//				byte.writeMultiByte(str.charAt(0), "gb2312");
//			}
//			
//			byte.position = 0;
//			var len:int = byte.length / 2;
//			for (var i:int = 0; i < len; i++ ) {
//				sortedArr[sortedArr.length] = { a:byte[i * 2], b:byte[i * 2 + 1], c:arr[i] };
//			}
//			sortedArr.sortOn(["a", "b"], [Array.DESCENDING | Array.NUMERIC]);
//			for each(var obj:Object in sortedArr) {
//				returnArr[returnArr.length] = obj.c;
//			}
//			return returnArr;
			var sortedArr:Array = [];
			var l:int = arr.length;
			for(var i:int = 0; i < l; i++){
				sortedArr[i] = {a:convertChar(arr[i]).charCodeAt(), b:arr[i]};
			}
			sortedArr.sortOn(["a"], [Array.NUMERIC]);
			
			var returnArr:Vector.<String> = new Vector.<String>();
			for each(var obj:Object in sortedArr) {
				returnArr[returnArr.length] = obj.b;
			}
			return returnArr;
		}
		
		/** 
		 * 获取中文第一个字的拼音首字母 
		 * @param chineseChar 
		 * @return 
		 * 
		 */   
		public static function convertChar(chineseChar:String):String 
		{ 
			var bytes:ByteArray = new ByteArray;
			bytes.writeMultiByte(chineseChar.charAt(0), "cn-gb"); 
			var n:int = bytes[0] << 8; 
			n += bytes[1]; 
			if (isIn(0xB0A1, 0xB0C4, n)) 
				return "a"; 
			if (isIn(0XB0C5, 0XB2C0, n)) 
				return "b"; 
			if (isIn(0xB2C1, 0xB4ED, n)) 
				return "c"; 
			if (isIn(0xB4EE, 0xB6E9, n)) 
				return "d"; 
			if (isIn(0xB6EA, 0xB7A1, n)) 
				return "e"; 
			if (isIn(0xB7A2, 0xB8c0, n)) 
				return "f"; 
			if (isIn(0xB8C1, 0xB9FD, n)) 
				return "g"; 
			if (isIn(0xB9FE, 0xBBF6, n)) 
				return "h"; 
			if (isIn(0xBBF7, 0xBFA5, n)) 
				return "j"; 
			if (isIn(0xBFA6, 0xC0AB, n)) 
				return "k"; 
			if (isIn(0xC0AC, 0xC2E7, n)) 
				return "l"; 
			if (isIn(0xC2E8, 0xC4C2, n)) 
				return "m"; 
			if (isIn(0xC4C3, 0xC5B5, n)) 
				return "n"; 
			if (isIn(0xC5B6, 0xC5BD, n)) 
				return "o"; 
			if (isIn(0xC5BE, 0xC6D9, n)) 
				return "p"; 
			if (isIn(0xC6DA, 0xC8BA, n)) 
				return "q"; 
			if (isIn(0xC8BB, 0xC8F5, n)) 
				return "r"; 
			if (isIn(0xC8F6, 0xCBF0, n)) 
				return "s"; 
			if (isIn(0xCBFA, 0xCDD9, n)) 
				return "t"; 
			if (isIn(0xCDDA, 0xCEF3, n)) 
				return "w"; 
			if (isIn(0xCEF4, 0xD188, n)) 
				return "x"; 
			if (isIn(0xD1B9, 0xD4D0, n)) 
				return "y"; 
			if (isIn(0xD4D1, 0xD7F9, n)) 
				return "z"; 
			return "\0"; 
		} 
		
		private static function isIn(from:int, to:int, value:int):Boolean 
		{ 
			return ((value >= from) && (value <= to)); 
		} 
	}

}