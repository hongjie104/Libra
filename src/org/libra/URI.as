package org.libra {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class URI
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/28/2013
	 * @version 1.0
	 * @see
	 */
	public final class URI {
		
		public static const RES_URL:String = '../asset/';
		
		public static const MODULE_URL:String = '../module/';
		
		static public var ip:String;
		
		static public var port:int;
		
		public static const UI_URL:String = RES_URL + 'ui/';
		
		static public const CONFIG_URL:String = RES_URL + 'config/';
		
		static public const AVATAR_URL:String = RES_URL + 'avatar/';
		
		public function URI() {
			throw new Error('URI类不允许被实例化');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}