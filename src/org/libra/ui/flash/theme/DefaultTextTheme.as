package org.libra.ui.flash.theme {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultLabelTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultTextTheme {
		
		protected var $width:int;
		
		protected var $height:int;
		
		protected var $font:JFont;
		
		protected var $filter:Array;
		
		public function DefaultTextTheme(w:int, h:int, font:JFont, filter:Array) {
			$width = w;
			$height = h;
			$font = font;
			$filter = filter;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get width():int {
			return $width;
		}
		
		public function get height():int {
			return $height;
		}
		
		public function get font():JFont {
			return $font;
		}
		
		public function get filter():Array {
			return $filter;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}