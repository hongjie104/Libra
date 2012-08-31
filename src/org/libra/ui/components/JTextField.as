package org.libra.ui.components {
	import flash.text.TextFieldType;
	import org.libra.ui.style.Style;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JTextField
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class JTextField extends JLabel {
		
		public function JTextField(text:String = '', x:Number = 0, y:Number = 0) { 
			super(text, x, y);
			this.mouseChildren = this.mouseEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		public function set restrict(val:String):void {
			this.textField.restrict = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			textField.selectable = textField.mouseEnabled = true;
			this.textField.type = TextFieldType.INPUT;
			textField.textColor = Style.INPUT_TEXT;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}