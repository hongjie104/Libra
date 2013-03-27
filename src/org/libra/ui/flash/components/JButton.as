package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.theme.DefaultBtnTheme;
	import org.libra.ui.managers.UIManager;
	
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
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 按钮上的文本
		 * @param	resName 按钮的皮肤资源
		 */
		public function JButton(theme:DefaultBtnTheme, x:int = 0, y:int = 0, text:String = '') { 
			super(theme, x, y, text);
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