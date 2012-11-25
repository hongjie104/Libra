package org.libra.ui.starling.component {
	import org.libra.ui.starling.core.BaseButton;
	import org.libra.ui.starling.theme.ButtonTheme;
	
	/**
	 * <p>
	 * 按钮类
	 * </p>
	 *
	 * @class JButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class JButton extends BaseButton {
		
		/**
		 * 构造函数
		 * @private
		 * @param	theme
		 * @param	widht
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function JButton(theme:ButtonTheme, widht:int, height:int, x:int = 0, y:int = 0, text:String = '') { 
			super(theme, widht, height, x, y, text);
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