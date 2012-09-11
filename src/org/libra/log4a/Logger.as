package org.libra.log4a {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Logger
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/05/2012
	 * @version 1.0
	 * @see
	 */
	public final class Logger {
		
		public static const INFO:int = 0;
		public static const DEBUG:int = 1;
		public static const WARN:int = 2;
		public static const ERROR:int = 3;
		
		public function Logger() {
			throw new Error('Logger不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function log(text:String, lv:int = 0):void {
			trace(lv + ':' + text);
			ExternalLogger.traceToBrowserConsole(text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}