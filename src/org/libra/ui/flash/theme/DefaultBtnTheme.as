package org.libra.ui.flash.theme {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultBtnTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultBtnTheme extends DefaultTextTheme {
		
		protected var $skin:String;
		
		public function DefaultBtnTheme(w:int, h:int, font:JFont, filter:Array, skin:String) { 
			super(w, h, font, filter);
			$skin = skin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get skin():String {
			return $skin;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}