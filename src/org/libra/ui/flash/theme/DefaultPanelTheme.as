package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultPanelTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultPanelTheme {
		
		protected var $resName:String;
		
		protected var $scale9Rect:Rectangle;
		
		public function DefaultPanelTheme(resName:String, scale9Rect:Rectangle) { 
			this.$resName = resName;
			this.$scale9Rect = scale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get resName():String {
			return $resName;
		}
		
		public function get scale9Rect():Rectangle {
			return $scale9Rect;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}