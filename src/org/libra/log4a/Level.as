package org.libra.log4a {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Level
	 * @author bright
	 */
	public final class Level {
		
		/**
		 * 所有层级
		 */
		public static var ALL : Level = new Level(0, "ALL");
		/**
		 * 调试层级
		 */
		public static var DEBUG : Level = new Level(1, "DEBUG");
		/**
		 * 信息层级
		 */
		public static var INFO : Level = new Level(2, "INFO");
		/**
		 * 警告层级
		 */
		public static var WARN : Level = new Level(3, "WARN");
		/**
		 * 错误层级
		 */
		public static var ERROR : Level = new Level(4, "ERROR");
		/**
		 * 失败层级
		 */
		public static var FATAL : Level = new Level(5, "FATAL");
		/**
		 * 关闭层级
		 */
		public static var OFF : Level = new Level(6, "OFF");
		
		private var _value : int;
		private var _name : String;
		
		/**
		 * 构造函数
		 * 
		 * @param value 层级变量 @default 1
		 * @param name 层级名称 @default "DEBUG"
		 */
		public function Level(value : int = 1, name : String = "DEBUG") {
			_value = value;
			_name = name;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		/**
		 * 获得层级变量
		 * 
		 * @return 
		 */
		public function get value():int {
			return _value;
		}

		/**
		 * 获得层级名称
		 * 
		 * @return 层级
		 */
		public function get name():String {
			return _name;
		}

		public function compareTo(level : Level):Boolean {
			return _value < level.value;
		}
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}