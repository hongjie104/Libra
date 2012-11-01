package org.libra.ui.flash.components {
	import flash.text.TextFieldType;
	import org.libra.ui.style.Style;
	import org.libra.ui.utils.JFont;
	
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
		
		public function JTextField(x:int = 0, y:int = 0, text:String = '') { 
			super(x, y, text);
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
		
		public function set displayAsPassword(val:Boolean):void {
			this.textField.displayAsPassword = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			this.setFont(JFont.FONT_INPUT);
			this.text = text;
			textField.selectable = textField.mouseEnabled = true;
			this.textField.type = TextFieldType.INPUT;
			textField.background = true;
			textField.backgroundColor = Style.BACKGROUND;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}