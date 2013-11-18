package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.BaseButton;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.BtnSkin;
	import org.libra.ui.flash.theme.JFont;
	
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
		public function JButton(x:int = 0, y:int = 0, skin:BtnSkin = null, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, skin ? skin : UIManager.instance.skin.btnSkin, text, font, filters);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Component {
			return new JButton(x, y, _skin as BtnSkin, _text, _font, _filters);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}