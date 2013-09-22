package org.libra.ui.flash.theme {
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Filter
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-30-2012
	 * @version 1.0
	 * @see
	 */
	public final class Filter {
		
		public static const SHADOW_FILTER:Array = [new DropShadowFilter(2, 45, Skin.DROPSHADOW, 1, 4, 4, .3, 1)];
		
		/**
		 * 黑色字体描边
		 */
		public static const BLACK:Array = [new GlowFilter(0x000000, 1, 2, 2, 10)];
		
		/**
		 * 投影
		 */
		//public static const DROP_SHADOW:Array = [new DropShadowFilter(2, 45, 0x000000, 1, 1, 1, 1, 1, false, false)];
		
		public function Filter() {
			throw new Error('Filter不能实例化!');
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