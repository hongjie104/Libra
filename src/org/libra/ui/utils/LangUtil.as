package org.libra.ui.utils {
	import org.libra.utils.HashMap;
	/**
	 * <p>
	 * 多语言工具
	 * </p>
	 *
	 * @class LangUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 02-29-2012
	 * @version 1.0
	 * @see
	 */
	public final class LangUtil {
		
		private static var instance:LangUtil;
		
		private var langMap:HashMap;
		
		public static var inited:Boolean = false;
		
		public function LangUtil(singleton:Singleton) {
			langMap = new HashMap();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 初始化多语言工具
		 * 将多语言按照key-value的形式存放在langMap中
		 */
		public function initLang(xml:XML):void {
 			var xmlList:XMLList = xml.string;
			var l:int = xmlList.length();
			for (var i:int = 0; i < l; i += 1) 
				langMap.put(xmlList[i].@name.toString(), xmlList[i].toString());
			inited = true;
		}
		
		public function getStr(key:String, ...rest):String { 
			var str:String = langMap.get(key);
			if (str) { 
				var l:int = rest.length;
				for (var i:int = 0; i < l; i++)
					str = str.replace(new RegExp("\\{" + i + "\\}", "g"), rest[i]);
				return str;
			}
			return key + "不在多语言中";
		}
		
		public static function getInstance():LangUtil {
			return instance ||= new LangUtil(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}

/**
 * @private
 */
final class Singleton{}