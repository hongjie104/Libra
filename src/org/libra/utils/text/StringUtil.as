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
		
		public static function isNullOrEmpty(str:String):Boolean {
			return str == null || str == "";
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
			var sortedArr:Array = [];
			var l:int = arr.length;
			for(var i:int = 0; i < l; i++){
//				sortedArr[i] = {a:convertChar(arr[i]).charCodeAt(), b:arr[i]};
//				sortedArr[i] = {a:toPinyin(arr[i], 1).charCodeAt(), b:arr[i]};
				sortedArr[i] = {a:toPinyin(arr[i], 1, true).charCodeAt(), b:arr[i]};
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
//		public static function convertChar(chineseChar:String):String 
//		{ 
//			var bytes:ByteArray = new ByteArray;
//			bytes.writeMultiByte(chineseChar.charAt(0), "cn-gb"); 
//			var n:int = bytes[0] << 8; 
//			n += bytes[1]; 
//			if (isIn(0xB0A1, 0xB0C4, n)) 
//				return "a"; 
//			if (isIn(0XB0C5, 0XB2C0, n)) 
//				return "b"; 
//			if (isIn(0xB2C1, 0xB4ED, n)) 
//				return "c"; 
//			if (isIn(0xB4EE, 0xB6E9, n)) 
//				return "d"; 
//			if (isIn(0xB6EA, 0xB7A1, n)) 
//				return "e"; 
//			if (isIn(0xB7A2, 0xB8c0, n)) 
//				return "f"; 
//			if (isIn(0xB8C1, 0xB9FD, n)) 
//				return "g"; 
//			if (isIn(0xB9FE, 0xBBF6, n)) 
//				return "h"; 
//			if (isIn(0xBBF7, 0xBFA5, n)) 
//				return "j"; 
//			if (isIn(0xBFA6, 0xC0AB, n)) 
//				return "k"; 
//			if (isIn(0xC0AC, 0xC2E7, n)) 
//				return "l"; 
//			if (isIn(0xC2E8, 0xC4C2, n)) 
//				return "m"; 
//			if (isIn(0xC4C3, 0xC5B5, n)) 
//				return "n"; 
//			if (isIn(0xC5B6, 0xC5BD, n)) 
//				return "o"; 
//			if (isIn(0xC5BE, 0xC6D9, n)) 
//				return "p"; 
//			if (isIn(0xC6DA, 0xC8BA, n)) 
//				return "q"; 
//			if (isIn(0xC8BB, 0xC8F5, n)) 
//				return "r"; 
//			if (isIn(0xC8F6, 0xCBF0, n)) 
//				return "s"; 
//			if (isIn(0xCBFA, 0xCDD9, n)) 
//				return "t"; 
//			if (isIn(0xCDDA, 0xCEF3, n)) 
//				return "w"; 
//			if (isIn(0xCEF4, 0xD188, n)) 
//				return "x"; 
//			if (isIn(0xD1B9, 0xD4D0, n)) 
//				return "y"; 
//			if (isIn(0xD4D1, 0xD7F9, n)) 
//				return "z"; 
//			return ""; 
//		} 
		
//		private static function isIn(from:int, to:int, value:int):Boolean 
//		{ 
//			return ((value >= from) && (value <= to)); 
//		} 
		
		private static const spell:Object = {0xB0A1:"a", 0xB0A3:"ai", 0xB0B0:"an", 0xB0B9:"ang", 0xB0BC:"ao", 0xB0C5:"ba", 0xB0D7:"bai", 0xB0DF:"ban", 0xB0EE:"bang", 0xB0FA:"bao", 0xB1AD:"bei", 0xB1BC:"ben", 0xB1C0:"beng", 0xB1C6:"bi", 0xB1DE:"bian", 0xB1EA:"biao", 0xB1EE:"bie", 0xB1F2:"bin", 0xB1F8:"bing", 0xB2A3:"bo", 0xB2B8:"bu", 0xB2C1:"ca", 0xB2C2:"cai", 0xB2CD:"can", 0xB2D4:"cang", 0xB2D9:"cao", 0xB2DE:"ce", 0xB2E3:"ceng", 0xB2E5:"cha", 0xB2F0:"chai", 0xB2F3:"chan", 0xB2FD:"chang", 0xB3AC:"chao", 0xB3B5:"che", 0xB3BB:"chen", 0xB3C5:"cheng", 0xB3D4:"chi", 0xB3E4:"chong", 0xB3E9:"chou", 0xB3F5:"chu", 0xB4A7:"chuai", 0xB4A8:"chuan", 0xB4AF:"chuang", 0xB4B5:"chui", 0xB4BA:"chun", 0xB4C1:"chuo", 0xB4C3:"ci", 0xB4CF:"cong", 0xB4D5:"cou", 0xB4D6:"cu", 0xB4DA:"cuan", 0xB4DD:"cui", 0xB4E5:"cun", 0xB4E8:"cuo", 0xB4EE:"da", 0xB4F4:"dai", 0xB5A2:"dan", 0xB5B1:"dang", 0xB5B6:"dao", 0xB5C2:"de", 0xB5C5:"deng", 0xB5CC:"di", 0xB5DF:"dian", 0xB5EF:"diao", 0xB5F8:"die", 0xB6A1:"ding", 0xB6AA:"diu", 0xB6AB:"dong", 0xB6B5:"dou", 0xB6BC:"du", 0xB6CB:"duan", 0xB6D1:"dui", 0xB6D5:"dun", 0xB6DE:"duo", 0xB6EA:"e", 0xB6F7:"en", 0xB6F8:"er", 0xB7A2:"fa", 0xB7AA:"fan", 0xB7BB:"fang", 0xB7C6:"fei", 0xB7D2:"fen", 0xB7E1:"feng", 0xB7F0:"fo", 0xB7F1:"fou", 0xB7F2:"fu", 0xB8C1:"ga", 0xB8C3:"gai", 0xB8C9:"gan", 0xB8D4:"gang", 0xB8DD:"gao", 0xB8E7:"ge", 0xB8F8:"gei", 0xB8F9:"gen", 0xB8FB:"geng", 0xB9A4:"gong", 0xB9B3:"gou", 0xB9BC:"gu", 0xB9CE:"gua", 0xB9D4:"guai", 0xB9D7:"guan", 0xB9E2:"guang", 0xB9E5:"gui", 0xB9F5:"gun", 0xB9F8:"guo", 0xB9FE:"ha", 0xBAA1:"hai", 0xBAA8:"han", 0xBABB:"hang", 0xBABE:"hao", 0xBAC7:"he", 0xBAD9:"hei", 0xBADB:"hen", 0xBADF:"heng", 0xBAE4:"hong", 0xBAED:"hou", 0xBAF4:"hu", 0xBBA8:"hua", 0xBBB1:"huai", 0xBBB6:"huan", 0xBBC4:"huang", 0xBBD2:"hui", 0xBBE7:"hun", 0xBBED:"huo", 0xBBF7:"ji", 0xBCCE:"jia", 0xBCDF:"jian", 0xBDA9:"jiang", 0xBDB6:"jiao", 0xBDD2:"jie", 0xBDED:"jin", 0xBEA3:"jing", 0xBEBC:"jiong", 0xBEBE:"jiu", 0xBECF:"ju", 0xBEE8:"juan", 0xBEEF:"jue", 0xBEF9:"jun", 0xBFA6:"ka", 0xBFAA:"kai", 0xBFAF:"kan", 0xBFB5:"kang", 0xBFBC:"kao", 0xBFC0:"ke", 0xBFCF:"ken", 0xBFD3:"keng", 0xBFD5:"kong", 0xBFD9:"kou", 0xBFDD:"ku", 0xBFE4:"kua", 0xBFE9:"kuai", 0xBFED:"kuan", 0xBFEF:"kuang", 0xBFF7:"kui", 0xC0A4:"kun", 0xC0A8:"kuo", 0xC0AC:"la", 0xC0B3:"lai", 0xC0B6:"lan", 0xC0C5:"lang", 0xC0CC:"lao", 0xC0D5:"le", 0xC0D7:"lei", 0xC0E2:"leng", 0xC0E5:"li", 0xC1A9:"lia", 0xC1AA:"lian", 0xC1B8:"liang", 0xC1C3:"liao", 0xC1D0:"lie", 0xC1D5:"lin", 0xC1E1:"ling", 0xC1EF:"liu", 0xC1FA:"long", 0xC2A5:"lou", 0xC2AB:"lu", 0xC2BF:"lv", 0xC2CD:"luan", 0xC2D3:"lue", 0xC2D5:"lun", 0xC2DC:"luo", 0xC2E8:"ma", 0xC2F1:"mai", 0xC2F7:"man", 0xC3A2:"mang", 0xC3A8:"mao", 0xC3B4:"me", 0xC3B5:"mei", 0xC3C5:"men", 0xC3C8:"meng", 0xC3D0:"mi", 0xC3DE:"mian", 0xC3E7:"miao", 0xC3EF:"mie", 0xC3F1:"min", 0xC3F7:"ming", 0xC3FD:"miu", 0xC3FE:"mo", 0xC4B1:"mou", 0xC4B4:"mu", 0xC4C3:"na", 0xC4CA:"nai", 0xC4CF:"nan", 0xC4D2:"nang", 0xC4D3:"nao", 0xC4D8:"ne", 0xC4D9:"nei", 0xC4DB:"nen", 0xC4DC:"neng", 0xC4DD:"ni", 0xC4E8:"nian", 0xC4EF:"niang", 0xC4F1:"niao", 0xC4F3:"nie", 0xC4FA:"nin", 0xC4FB:"ning", 0xC5A3:"niu", 0xC5A7:"nong", 0xC5AB:"nu", 0xC5AE:"nv", 0xC5AF:"nuan", 0xC5B0:"nue", 0xC5B2:"nuo", 0xC5B6:"o", 0xC5B7:"ou", 0xC5BE:"pa", 0xC5C4:"pai", 0xC5CA:"pan", 0xC5D2:"pang", 0xC5D7:"pao", 0xC5DE:"pei", 0xC5E7:"pen", 0xC5E9:"peng", 0xC5F7:"pi", 0xC6AA:"pian", 0xC6AE:"piao", 0xC6B2:"pie", 0xC6B4:"pin", 0xC6B9:"ping", 0xC6C2:"po", 0xC6CB:"pu", 0xC6DA:"qi", 0xC6FE:"qia", 0xC7A3:"qian", 0xC7B9:"qiang", 0xC7C1:"qiao", 0xC7D0:"qie", 0xC7D5:"qin", 0xC7E0:"qing", 0xC7ED:"qiong", 0xC7EF:"qiu", 0xC7F7:"qu", 0xC8A6:"quan", 0xC8B1:"que", 0xC8B9:"qun", 0xC8BB:"ran", 0xC8BF:"rang", 0xC8C4:"rao", 0xC8C7:"re", 0xC8C9:"ren", 0xC8D3:"reng", 0xC8D5:"ri", 0xC8D6:"rong", 0xC8E0:"rou", 0xC8E3:"ru", 0xC8ED:"ruan", 0xC8EF:"rui", 0xC8F2:"run", 0xC8F4:"ruo", 0xC8F6:"sa", 0xC8F9:"sai", 0xC8FD:"san", 0xC9A3:"sang", 0xC9A6:"sao", 0xC9AA:"se", 0xC9AD:"sen", 0xC9AE:"seng", 0xC9AF:"sha", 0xC9B8:"shai", 0xC9BA:"shan", 0xC9CA:"shang", 0xC9D2:"shao", 0xC9DD:"she", 0xC9E9:"shen", 0xC9F9:"sheng", 0xCAA6:"shi", 0xCAD5:"shou", 0xCADF:"shu", 0xCBA2:"shua", 0xCBA4:"shuai", 0xCBA8:"shuan", 0xCBAA:"shuang", 0xCBAD:"shui", 0xCBB1:"shun", 0xCBB5:"shuo", 0xCBB9:"si", 0xCBC9:"song", 0xCBD1:"sou", 0xCBD4:"su", 0xCBE1:"suan", 0xCBE4:"sui", 0xCBEF:"sun", 0xCBF2:"suo", 0xCBFA:"ta", 0xCCA5:"tai", 0xCCAE:"tan", 0xCCC0:"tang", 0xCCCD:"tao", 0xCCD8:"te", 0xCCD9:"teng", 0xCCDD:"ti", 0xCCEC:"tian", 0xCCF4:"tiao", 0xCCF9:"tie", 0xCCFC:"ting", 0xCDA8:"tong", 0xCDB5:"tou", 0xCDB9:"tu", 0xCDC4:"tuan", 0xCDC6:"tui", 0xCDCC:"tun", 0xCDCF:"tuo", 0xCDDA:"wa", 0xCDE1:"wai", 0xCDE3:"wan", 0xCDF4:"wang", 0xCDFE:"wei", 0xCEC1:"wen", 0xCECB:"weng", 0xCECE:"wo", 0xCED7:"wu", 0xCEF4:"xi", 0xCFB9:"xia", 0xCFC6:"xian", 0xCFE0:"xiang", 0xCFF4:"xiao", 0xD0A8:"xie", 0xD0BD:"xin", 0xD0C7:"xing", 0xD0D6:"xiong", 0xD0DD:"xiu", 0xD0E6:"xu", 0xD0F9:"xuan", 0xD1A5:"xue", 0xD1AB:"xun", 0xD1B9:"ya", 0xD1C9:"yan", 0xD1EA:"yang", 0xD1FB:"yao", 0xD2AC:"ye", 0xD2BB:"yi", 0xD2F0:"yin", 0xD3A2:"ying", 0xD3B4:"yo", 0xD3B5:"yong", 0xD3C4:"you", 0xD3D9:"yu", 0xD4A7:"yuan", 0xD4BB:"yue", 0xD4C5:"yun", 0xD4D1:"za", 0xD4D4:"zai", 0xD4DB:"zan", 0xD4DF:"zang", 0xD4E2:"zao", 0xD4F0:"ze", 0xD4F4:"zei", 0xD4F5:"zen", 0xD4F6:"zeng", 0xD4FA:"zha", 0xD5AA:"zhai", 0xD5B0:"zhan", 0xD5C1:"zhang", 0xD5D0:"zhao", 0xD5DA:"zhe", 0xD5E4:"zhen", 0xD5F4:"zheng", 0xD6A5:"zhi", 0xD6D0:"zhong", 0xD6DB:"zhou", 0xD6E9:"zhu", 0xD7A5:"zhua", 0xD7A7:"zhuai", 0xD7A8:"zhuan", 0xD7AE:"zhuang", 0xD7B5:"zhui", 0xD7BB:"zhun", 0xD7BD:"zhuo", 0xD7C8:"zi", 0xD7D7:"zong", 0xD7DE:"zou", 0xD7E2:"zu", 0xD7EA:"zuan", 0xD7EC:"zui", 0xD7F0:"zun", 0xD7F2:"zuo"};
	
		/**
		 * 将中文字符转为拼音
		 * @param str 原字符串
		 * @param len 要解析的字符个数，默认为0，即所有字符
		 * @param abbreviative 是否转为缩写拼音，只提取拼音首字母
		 * @param addSpace 是否在中文字间加空格
		 * @param filterOther 是否过滤非中文字符
		 * @return 转换好的字符串
		 * 
		 */
		public static function toPinyin(str:String, len:int = 0, abbreviative:Boolean=false, addSpace:Boolean=false, filterOther:Boolean=false):String{
			if (str) {
				var result:String = "";
				var pStr:String;
				var linkPY:Boolean = false;
				
				var length:int = (len < 1 || len > str.length) ? str.length : len;
				for (var ii:int = 0; ii < length; ii++) {
					pStr = pinyin(str.charAt(ii));
					if (pStr == null){
						if (!filterOther){
//							result = result + str.charAt(ii);
							result += "_";
							linkPY = false;
						}
					}else{
						if(abbreviative){
							result = result + pStr.substr(0, 1).toUpperCase();
						}else{
							result = result + (linkPY && addSpace ? " " : "") + pStr;
							linkPY = true;
						}
					}
				}
				return result;
			}else{
				return "";
			}
		}
		
		private static function pinyin(char:String):String {
			if (!char.charCodeAt(0) || char.charCodeAt(0) < 128) {
				return null;
			}
			var ascCode:int = unicodeToAnsi(char);
			if (!(ascCode > 0xB0A0 && ascCode < 0xD7FC)) {
				return null;
			}
			for (var ii:int = ascCode; (!spell[ii] && ii > 0); ) {
				ii--;
			}
			return spell[ii];
		}
		
		private static function unicodeToAnsi(str:String):int{
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(str, "gb2312");
			byte.position = 0;
			if (byte.length > 1){
				return byte.readUnsignedShort();
			}else{
				return byte.readUnsignedByte();
			}
		}
		
		/**
		 * 将一个由分隔符分个的字符串转换成多维数组
		 * @param $str 要转换的字符串
		 * @param $sep 字符串分隔符数组，按纬度排序
		 * @example 将字符串转换成2维数组，一维分隔符为;，二维分隔符为:。
		 * <list version="3.0">
		 * var __str:String = "15:10;511:100:75:85";
		 * trace(StringUtil.toMultiArray(__str, [';',':']).length);
		 * </list>
		 */
		public static function toMultiArray($str:String, $sep:Array):Array
		{
			if(!$str || !$sep || $sep.length==0) return null;
			var __arr:Array = [];
			while($sep.length>0)
			{
				var __sep:String = $sep.shift();
				if(__arr.length == 0)
				{
					__arr = $str.split(__sep);
				}
				else
				{
					for (var j:int = 0; j < __arr.length; j++) 
					{
						__arr[j] = String(__arr[j]).split(__sep);
					}
					
				}
			}
			return __arr;
		}
		
		/**
		 * 把一个数字输出成浮点形式的字符串
		 * @param $num 要处理的数字
		 * @param $decimals 小数的位数
		 */
		public static function float2String($num:Number, $dedimals:uint=1):String
		{
			var __float:String = $num.toString();
			var __floatArr:Array = __float.split('.');
			if(__floatArr.length>1)
			{
				if($dedimals>0)
				{
					var __decimal:String = __floatArr[1];
					if(__decimal.length>$dedimals)
					{
						__decimal = __decimal.slice(0, $dedimals);
					}
					else
					{
						while(__decimal.length<$dedimals)
							__decimal += '0';
					}
					return __floatArr[0] + '.' + __decimal;
				}
				else
				{
					return __floatArr[0].toString();
				}
			}
			if($dedimals>0)
			{
				__float += '.';
				for(var i:int=0; i<$dedimals;i++)
				{
					__float += '0';
				}
			}
			return __float;
		}
		
		/**
		 * 使用$value数组中的键值替换指定字符串内的“{key}”标记。key的值来自于$key数组
		 * @param $str 要在其中进行替换的字符串。该字符串可包含 {key} 形式的特殊标记，其中key的值与$key数组中的元素相同，它将被$value中相同索引的元素替换。
		 * @param $key 要替换的键名数组
		 * @param $value 被替换的值的数组，值的索引与键名的索引要一一对应
		 * @return 完成替换的新字符串
		 */		
		public static function substituteFromKey($str:String, $key:Array, $value:Array):String
		{
			if($str == null)
				return '';
			var __str:String = $str;
			for(var i:int=0; i<$key.length; i++)
			{
				__str = __str.replace(new RegExp("\\{"+$key[i]+"\\}", "g"), $value[i]);
			}
			return __str;
		}
		
		/**
		 * 测试一个字符串是否为真
		 */		
		public static function isTrue($str:String):Boolean
		{
			return trim($str).toLocaleLowerCase() === 'true';
		}
		
		/**
		 * 检测一个字符串是否是[a,b]的形式，仅支持一维数组 
		 */		
		public static function isArray($str:String):Boolean
		{
			var _reg:RegExp = /^\[[^\[\]]*\]$/g;
			return _reg.test($str);
		}
		
		/**
		 * 使用传入的各个参数替换指定的字符串内的“{n}”标记。n从0开始
		 * @param str  要在其中进行替换的字符串。该字符串可包含 {n} 形式的特殊标记，其中 n 为从零开始的索引，它将被该索引处的其他参数（如果指定）替换。
		 * @param rest 可在 str 参数中的每个 {n} 位置被替换的其他参数，其中 n 是一个对指定值数组的整数索引值（从 0 开始）。如果第一个参数是一个数组，则该数组将用作参数列表。
		 * @author Adobe.com
		 */		
		public static function substitute(str:String, ... rest):String
		{
			if (str == null) return '';
			
			// Replace all of the parameters in the msg string.
			var len:uint = rest.length;
			var args:Array;
			if (len == 1 && rest[0] is Array)
			{
				args = rest[0] as Array;
				len = args.length;
			}
			else
			{
				args = rest;
			}
			
			for (var i:int = 0; i < len; i++)
			{
				str = str.replace(new RegExp("\\{"+i+"\\}", "g"), args[i]);
			}
			
			return str;
		}
		
		/**
		 *  删除数组中每个元素的开头和末尾的所有空格字符，此处数组作为字符串存储。
		 *  @param value 要去掉其空格字符的字符串。
		 *  @param separator 分隔字符串中的每个数组元素的字符串。
		 *  @return 删除了每个元素的开头和末尾空格字符的更新字符串。
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 * 	@author Adobe.com
		 */
		public static function trimArrayElements(value:String, delimiter:String):String
		{
			if (value != "" && value != null)
			{
				var items:Array = value.split(delimiter);
				
				var len:int = items.length;
				for (var i:int = 0; i < len; i++)
				{
					items[i] = StringUtil.trim(items[i]);
				}
				
				if (len > 0)
				{
					value = items.join(delimiter);
				}
			}
			
			return value;
		}
		
		/**
		 *  如果指定的字符串是单个空格、制表符、回车符、换行符或换页符，则返回 true。
		 *  @param str 查询的字符串。
		 *  @return 如果指定的字符串是单个空格、制表符、回车符、换行符或换页符，则为<code>true</code>。
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 * 	@author Adobe.com
		 */
		public static function isWhitespace(character:String):Boolean
		{
			switch (character)
			{
				case " ":
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
					
				default:
					return false;
			}
		}
		
		/**
		 *  从字符串中删除“不允许的”字符。“限制字符串”（如 <code>"A-Z0-9"</code>）用于指定允许的字符。此方法使用的是与 TextField 的 <code>restrict</code> 属性相同的逻辑。Removes "unallowed" characters from a string.
		 *  @param str 输入字符串。
		 *  @param restrict 限制字符串。
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 9
		 *  @playerversion AIR 1.1
		 *  @productversion Flex 3
		 *  @author Adobe.com
		 */
		public static function restrict(str:String, restrict:String):String
		{
			// A null 'restrict' string means all characters are allowed.
			if (restrict == null)
				return str;
			
			// An empty 'restrict' string means no characters are allowed.
			if (restrict == "")
				return "";
			
			// Otherwise, we need to test each character in 'str'
			// to determine whether the 'restrict' string allows it.
			var charCodes:Array = [];
			
			var n:int = str.length;
			for (var i:int = 0; i < n; i++)
			{
				var charCode:uint = str.charCodeAt(i);
				if (testCharacter(charCode, restrict))
					charCodes.push(charCode);
			}
			
			return String.fromCharCode.apply(null, charCodes);
		}
		
		/**
		 *  @private
		 *  Helper method used by restrict() to test each character
		 *  in the input string against the restriction string.
		 *  The logic in this method implements the same algorithm
		 *  as in TextField's 'restrict' property (which is quirky,
		 *  such as how it handles a '-' at the beginning of the
		 *  restriction string).
		 */
		private static function testCharacter(charCode:uint, restrict:String):Boolean
		{
			var allowIt:Boolean = false;
			
			var inBackSlash:Boolean = false;
			var inRange:Boolean = false;
			var setFlag:Boolean = true;
			var lastCode:uint = 0;
			
			var n:int = restrict.length;
			var code:uint;
			
			if (n > 0)
			{
				code = restrict.charCodeAt(0);
				if (code == 94) // caret
					allowIt = true;
			}
			
			for (var i:int = 0; i < n; i++)
			{
				code = restrict.charCodeAt(i)
				
				var acceptCode:Boolean = false;
				if (!inBackSlash)
				{
					if (code == 45) // hyphen
						inRange = true;
					else if (code == 94) // caret
						setFlag = !setFlag;
					else if (code == 92) // backslash
						inBackSlash = true;
					else
						acceptCode = true;
				}
				else
				{
					acceptCode = true;
					inBackSlash = false;
				}
				
				if (acceptCode)
				{
					if (inRange)
					{
						if (lastCode <= charCode && charCode <= code)
							allowIt = setFlag;
						inRange = false;
						lastCode = 0;
					}
					else
					{
						if (charCode == code)
							allowIt = setFlag;
						lastCode = code;
					}
				}
			}
			
			return allowIt;
		}
		
		public static var NEWLINE_TOKENS : Array = new Array (
			'\n',
			'\r'
		);
		
		public static var WHITESPACE_TOKENS : Array = new Array (
			' ',
			'\t'
		);
		
		public static function count ( haystack : String, needle : String, offset : Number = 0, length : Number = 0 ) : Number
		{
			if ( length === 0 )
				length = haystack.length
			var result : Number = 0;
			haystack = haystack.slice( offset, length );
			while ( haystack.length > 0 && haystack.indexOf( needle ) != -1 )
			{
				haystack = haystack.slice( ( haystack.indexOf( needle ) + needle.length ) );
				result++;
			}
			return result;
		}
		
		public static function trimList ( str : String, charList : Array = null ) : String
		{
			var list : Array;
			if ( charList )
				list = charList;
			else
				list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			str = trimLeft2( str, list );
			str = trimRight2( str, list );
			return str;
		}
		
		public static function trimLeft2 ( str : String, charList : Array = null ) : String
		{
			var list:Array;
			if ( charList )
				list = charList;
			else
				list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			
			while ( list.toString().indexOf ( str.substr ( 0, 1 ) ) > -1 && str.length > 0 )
				str = str.substr ( 1 );
			return str;
		}
		
		public static function trimRight2 ( str:String, charList : Array = null ) : String
		{
			var list : Array;
			if ( charList )
				list = charList;
			else
				list = WHITESPACE_TOKENS.concat( NEWLINE_TOKENS );
			
			while ( list.toString().indexOf ( str.substr ( str.length - 1 ) ) > -1 && str.length > 0)
				str = str.substr ( 0, str.length - 1 );
			return str;
		}
		
	}

}