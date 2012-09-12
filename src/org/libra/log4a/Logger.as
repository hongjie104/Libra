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
		
		public static var level:Level = new Level( -1, 'ALL');
		
		public function Logger() {
			throw new Error('Logger不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function debug(msg:String):void {
			if (Level.DEBUG.compareTo(level)) {
				trace('1:[' + Level.DEBUG.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.debug', msg);
			}
		}
		
		public static function info(msg:String):void {
			if (Level.INFO.compareTo(level)) {
				trace('0:[' + Level.INFO.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.info', msg);
			}
		}
		
		public static function warn(msg:String):void {
			if (Level.WARN.compareTo(level)) {
				trace('2:[' + Level.WARN.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.warn', msg);
			}
		}
		
		public static function error(msg:String):void {
			if (Level.ERROR.compareTo(level)) {
				trace('3:[' + Level.ERROR.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.error', msg);
			}
		}
		
		public static function fatal(msg:String):void {
			if (Level.FATAL.compareTo(level)) {
				trace('4:[' + Level.FATAL.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.error', msg);
			}
		}
		
		public static function off(msg:String):void {
			if (Level.OFF.compareTo(level)) {
				trace('5:[' + Level.OFF.name + ']' + msg);
				ExternalLogger.traceToBrowserConsole('console.log', msg);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}