package org.libra.ui.flash.theme {
	import flash.geom.Rectangle;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultFrameTheme
	 * @author Eddie
	 * @qq 32968210
	 * @date 03/31/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultFrameTheme extends DefaultPanelTheme {
		
		private var $closeBtnTheme:DefaultBtnTheme;
		
		public function DefaultFrameTheme(resName:String, scale9Rect:Rectangle) {
			super(resName, scale9Rect);
			$closeBtnTheme = new DefaultBtnTheme(21, 19, JFont.FONT_BTN, Filter.BLACK, 'btnClose');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get closeBtnTheme():DefaultBtnTheme {
			return $closeBtnTheme;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}