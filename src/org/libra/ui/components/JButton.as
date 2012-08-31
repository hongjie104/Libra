package org.libra.ui.components {
	import org.libra.ui.base.BaseButton;
	
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
		
		public function JButton(resName:String = 'btn', text:String='', x:Number=0, y:Number=0) {
			super(resName, text, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			textField.textColor = 0xffb932;
			this.textAlign = 'center';
			this.text = text;
			setTextLocation(0, 8);
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}