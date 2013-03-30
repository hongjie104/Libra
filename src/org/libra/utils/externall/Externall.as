package org.libra.utils.externall {
	import flash.external.ExternalInterface;
	import org.libra.utils.text.StringUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Externall
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/29/2013
	 * @version 1.0
	 * @see
	 */
	public final class Externall {
		
		public static var provider:String = "apowo";
		
		public static var serverID:int = 1;
		
		/**
		 * 自动登录时的账号
		 */
		public static var autoAccount:String = "";
		
		/**
		 * 自动登录时的密码
		 */
		public static var autoPassword:String = "";
		
		/**
		 * 是否成年
		 */
		public static var isAdult:Boolean = true;
		
		public function Externall() {
			throw new Error("Externall类无法实例化");
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function initArgs():void {
			if (!ExternalInterface.available) return;
			var args:String = ExternalInterface.call("function getArgs(){return location.search;}").toString();
			if (args) {
				var ary:Array = StringUtil.replace(args, "?", "").split("&");
				//先找出provider
				var a:Array = null;
				for each(var i:String in ary) {
					a = i.split("=");
					if (a[0] == "from") {
						if (a.length == 3) a[1] += "=" + a[2];
						provider = a[1];
						break;
					}
				}
				
				//根据provider不同解析网页参数
				switch(provider) {
					case 'apowo':
						for each(var keyVal:String in ary) {
							a = keyVal.split("=");
							switch(a[0].toLowerCase()) {
								case 'serverid':
									serverID = a[1];
									break;
							}
						}
						break;
				}
			}
		}
		
		/**
		 * 是否自动登录
		 * @return
		 */
		public static function isAutoLogin():Boolean {
			return provider != 'apowo';
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}