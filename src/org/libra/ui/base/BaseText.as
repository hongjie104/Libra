package org.libra.ui.base {
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.libra.ui.style.Filter;
	import org.libra.ui.style.Style;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseText
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseText extends Component {
		
		/**
		 * 文本组件，flash自带的
		 */
		protected var textField:TextField;
		
		public function BaseText(text:String = '', x:Number = 0, y:Number = 0) { 
			super(x, y);
			this.initTextField(text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			this.textField.width = w - textField.x;
			this.textField.height = h - textField.y;
		}
		
		public function appendText(text:String):void {
			this.textField.appendText(text);
		}
		
		public function setTextLocation(x:int, y:int):void {
			this.textField.x = x;
			this.textField.y = y;
			this.textField.width = $width - x;
			this.textField.height = $height - y;
		}
		
		/**
		 * 设置文本框中，被选中的文本段
		 * @param	beginIndex 选中文本第一个字符的索引值
		 * @param	endIndex选中文本最后一个字符的索引值
		 */
		public function setSelection(beginIndex:int, endIndex:int):void {
			this.textField.setSelection(beginIndex, endIndex);
		}
		
		/**
		 * 多行显示时，设置行间距
		 * @param	value
		 */
		//public function setLeading(value:int):void {
			//var tf:TextFormat = this.textField.defaultTextFormat;
			//var newTf:TextFormat = new TextFormat();
			//newTf.leading = value;
			//如果有旧的TextFormat，那么将其对齐方式赋值给新的TextFormat
			//if (tf) {
				//newTf.align = tf.align;
				//newTf.font = tf.font;
			//}
			//this.textField.setTextFormat(newTf);
			//this.textField.defaultTextFormat = newTf;
		//}
		
		override public function toString():String {
			return 'BaseText';
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		public function set text(text:String):void {
			this.textField.text = text;
		}
		
		public function get text():String {
			return this.textField.text;
		}
		
		public function set htmlText(text:String):void {
			this.textField.htmlText = text;
		}
		
		public function get htmlText():String {
			return this.textField.htmlText;
		}
		
		public function get textLength():int {
			return this.textField.length;
		}
		
		public function set wordWrap(val:Boolean):void {
			this.textField.wordWrap = val;
		}
		
		public function set textColor(color:int):void {
			this.textField.textColor = color;
		}
		
		public function set textFilter(filter:Array):void {
			this.textField.filters = filter;
		}
		
		public function set textAlign(val:String):void {
			var tf:TextFormat = this.textField.defaultTextFormat;
			tf.align = val;
			this.textField.defaultTextFormat = tf;
		}
		
		public function set maxChars(val:int):void {
			this.textField.maxChars = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function initTextField(text:String = ''):void {
			if (!textField) {
				textField = new TextField();
				textField.selectable = textField.tabEnabled = textField.mouseWheelEnabled = textField.mouseEnabled = textField.doubleClickEnabled = false;
				textField.multiline = false;
				textField.defaultTextFormat = new TextFormat(Style.fontName, Style.fontSize, Style.LABEL_TEXT);
			}
			textField.text = text;
			textField.filters = Filter.BLACK;
			this.addChild(textField);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}