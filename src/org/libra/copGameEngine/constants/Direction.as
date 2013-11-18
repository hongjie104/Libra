package org.libra.copGameEngine.constants {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Direction
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 09/06/2013
	 * @version 1.0
	 * @see
	 */
	public final class Direction {
		
		public static const UP:int = 0;
		
		public static const LEFT_UP:int = 1;
		
		public static const LEFT:int = 2;
		
		public static const LEFT_DOWN:int = 3;
		
		public static const DOWN:int = 4;
		
		public static const RIGHT_DOWN:int = 5;
		
		public static const RIGHT:int = 6;
		
		public static const RIGHT_UP:int = 7;
		
		/**
		 * 方向
		 * 1       0       7
		 *         ↑
		 *       ↖ ↗
		 * 2    ←     →    6
		 *       ↙ ↘
		 * 		   ↓
		 * 3       4       5
		 */
		public function Direction() {
			throw new Error('Direction无法实例化')
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