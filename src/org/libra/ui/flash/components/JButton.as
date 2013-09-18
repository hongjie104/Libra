package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultBtnTheme;
	
	/**
	 * <p>
	 * 按钮类
	 * </p>
	 *
	 * @class JButton
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JButton extends BaseButton {
		
		/**
		 * 构造函数
		 * @param	theme
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function JButton(theme:DefaultBtnTheme = null, x:int = 0, y:int = 0, text:String = '') { 
			super(theme ? theme : UIManager.getInstance().theme.btnTheme, x, y, text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Component {
			return new JButton($theme as DefaultBtnTheme, x, y, $text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}