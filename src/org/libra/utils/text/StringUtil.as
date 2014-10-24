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
		 *
		 * ************************************
		 *
		 *     GB2312 字库中文排序
		 *
		 * ************************************
		 * @author Abel
		 * @since 2010年4月14日
		 * @usage SortByGB2312.sort(["在这里","阿里巴巴","淘宝网"]);
		 *
		 */
		public static function sort(arr:Array):Array {
			var byte:ByteArray = new ByteArray();
			var sortedArr:Array = [];
			var returnArr:Array = []
			for each(var str:String in arr) {
				byte.writeMultiByte(str.charAt(0), "gb2312");
			}
			
			byte.position = 0;
			var len:int = byte.length / 2;
			for (var i:int = 0; i < len; i++ ) {
				sortedArr[sortedArr.length] = { a:byte[i * 2], b:byte[i * 2 + 1], c:arr[i] };
			}
			sortedArr.sortOn(["a", "b"], [Array.DESCENDING | Array.NUMERIC]);
			for each(var obj:Object in sortedArr) {
				returnArr[returnArr.length] = obj.c;
			}
			return returnArr;
		}
	}

}