package org.libra.ui.flash.components {
	import org.libra.ui.flash.core.BaseButton;
	
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
		public function JButton(x:int = 0, y:int = 0, text:String = '', resName:String = 'btn') { 
			super(x, y, text, resName);
			this.setSize(43, 26);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 * @param	w
		 * @param	h
		 */
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			setTextLocation(0, h - 21);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}