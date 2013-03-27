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
		
		protected var $resName:String;
		
		public function DefaultBtnTheme(w:int, h:int, font:JFont, filter:Array, resName:String) { 
			super(w, h, font, filter);
			$resName = resName;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get resName():String {
			return $resName;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}