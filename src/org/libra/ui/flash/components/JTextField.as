package org.libra.ui.flash.components {
	import flash.text.TextFieldType;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.flash.theme.Skin;
	import org.libra.utils.MathUtil;
	
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
		
		/**
		 * 是否可以编辑
		 * @default true
		 * @private
		 */
		protected var $editable:Boolean;
		
		public function JTextField(x:int = 0, y:int = 0, text:String = null, font:JFont = null, filters:Array = null) { 
			super(x, y, text, font?font:JFont.FONT_INPUT, filters);
			this.mouseChildren = this.mouseEnabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toXML():XML {
			const xml:XML = super.toXML();
			if (this.displayAsPassword) xml.@displayAsPassword = true;
			if (this.$textField.background) xml.@backgroundColor = $textField.backgroundColor;
			return xml;
		}
		
		override public function clone():Component {
			const tf:JTextField = new JTextField(x, y, $text, $font, $filters);
			tf.displayAsPassword = this.displayAsPassword;
			return tf;
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		public function get editable():Boolean {
			return this.$editable;
		}
		
		public function set editable(val:Boolean):void {
			$editable = val;
			$textField.type = val ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		public function set restrict(val:String):void {
			this.$textField.restrict = val;
		}
		
		public function set displayAsPassword(val:Boolean):void {
			this.$textField.displayAsPassword = val;
		}
		
		public function get displayAsPassword():Boolean {
			return $textField.displayAsPassword;
		}
		
		public function get backgroundColor():int {
			return $textField.background ? $textField.backgroundColor : -1;
		}
		
		public function set backgroundColor(value:int):void {
			$textField.background = value >= 0
			$textField.backgroundColor = MathUtil.max(value, 0);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			this.setFont($font);
			this.text = text;
			$textField.selectable = $textField.mouseEnabled = true;
			$editable = true;
			this.$textField.type = TextFieldType.INPUT;
			backgroundColor = Skin.BACKGROUND;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}