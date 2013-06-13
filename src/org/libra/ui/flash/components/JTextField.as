package org.libra.ui.flash.components {
	import flash.text.TextFieldType;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTextTheme;
	import org.libra.ui.flash.theme.DefaultTheme;
	import org.libra.ui.flash.theme.JFont;
	
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
		
		public function JTextField(theme:DefaultTextTheme = null, x:int = 0, y:int = 0, text:String = '') { 
			super(theme ? theme : UIManager.getInstance().theme.textFieldTheme, x, y, text);
			this.mouseChildren = this.mouseEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		public function set restrict(val:String):void {
			this.$textField.restrict = val;
		}
		
		public function set displayAsPassword(val:Boolean):void {
			this.$textField.displayAsPassword = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			this.setFont($theme.font);
			this.text = text;
			$textField.selectable = $textField.mouseEnabled = true;
			this.$textField.type = TextFieldType.INPUT;
			$textField.background = true;
			$textField.backgroundColor = DefaultTheme.BACKGROUND;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}