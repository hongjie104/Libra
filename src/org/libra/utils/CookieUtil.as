package org.libra.utils {
	import flash.external.ExternalInterface;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class CookieUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-10-2012
	 * @version 1.0
	 * @see
	 */
	public final class CookieUtil {
		
		public function CookieUtil() {
			throw new Error('CookieUtil无法实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getCookie(cookieName:String):String { 
			var r:String = "";
			var search:String = cookieName + "=";
			var js:String = "function get_cookie(){return document.cookie;}";
			var o:Object = ExternalInterface.call(js);
			var cookieVariable:String = o.toString();
			
			if (cookieVariable.length) { 
				var offset:int = cookieVariable.indexOf(search);
				if (offset != -1) {
					offset += search.length;
					var end:int = cookieVariable.indexOf(";", offset);
					if (end == -1)
						end = cookieVariable.length;
					r = unescape(cookieVariable.substring(offset, end));
				}
			}
			return r;
		}
		
		public function setCookie(cookieName:String, cookieValue:String):void { 
			var js:String = "function sc(){var c = escape('" + cookieName + "') + '=' + escape('" + cookieValue + 
				"') + '; path=/';document.cookie = c;}";
			ExternalInterface.call(js);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}