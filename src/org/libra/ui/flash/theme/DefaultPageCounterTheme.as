package org.libra.ui.flash.theme {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultPageCounterTheme
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultPageCounterTheme {
		
		protected var $prevBtnTheme:DefaultBtnTheme;
		
		protected var $nextBtnTheme:DefaultBtnTheme;
		
		protected var $countLabelTheme:DefaultTextTheme;
		
		protected var $width:int;
		
		protected var $height:int;
		
		public function DefaultPageCounterTheme(prevBtnTheme:DefaultBtnTheme, nextBtnTheme:DefaultBtnTheme, countLabelTheme:DefaultTextTheme, width:int = 80, height:int = 20) { 
			$prevBtnTheme = prevBtnTheme;
			$nextBtnTheme = nextBtnTheme;
			$countLabelTheme = countLabelTheme;
			$width = width;
			$height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get prevBtnTheme():DefaultBtnTheme {
			return $prevBtnTheme;
		}
		
		public function get nextBtnTheme():DefaultBtnTheme {
			return $nextBtnTheme;
		}
		
		public function get countLabelTheme():DefaultTextTheme {
			return $countLabelTheme;
		}
		
		public function get width():int {
			return $width;
		}
		
		public function get height():int {
			return $height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}