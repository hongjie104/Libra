package org.libra.ui.flash.theme {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class DefaultComboBoxTheme
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/27/2013
	 * @version 1.0
	 * @see
	 */
	public class DefaultComboBoxTheme {
		
		protected var $contentTheme:DefaultTextTheme;
		
		protected var $pressBtnTheme:DefaultBtnTheme;
		
		protected var $width:int;
		
		protected var $height:int;
		
		public function DefaultComboBoxTheme(contentTheme:DefaultTextTheme, pressBtnTheme:DefaultBtnTheme, width:int = 100, height:int = 20) { 
			this.$contentTheme = contentTheme;
			this.$pressBtnTheme = pressBtnTheme;
			this.$width = width;
			this.$height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get contentTheme():DefaultTextTheme {
			return $contentTheme;
		}
		
		public function get pressBtnTheme():DefaultBtnTheme {
			return $pressBtnTheme;
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