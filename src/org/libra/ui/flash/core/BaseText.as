package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.libra.ui.style.Filter;
	import org.libra.ui.text.JFont;
	
	/**
	 * <p>
	 * 文本的控件的父类
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
		
		public function BaseText(x:int = 0, y:int = 0, text:String = '') { 
			super(x, y);
			this.initTextField(text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
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
			this.textField.width = actualWidth - x;
			this.textField.height = actualHeight - y;
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
		 * 设置文本字体，每次将Textfield的text重置时，Textfield都会将其TextFormat设置为默认的TextFormat，
		 * 所以该方法修改的不仅仅是Textfield的TextFormat，还有defaultTextFormat
		 * @param	font
		 */
		public function setFont(font:JFont):void {
			var newTf:TextFormat = font.getTextFormat();
			this.textField.setTextFormat(newTf);
			this.textField.defaultTextFormat = newTf;
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
			this.textField.setTextFormat(tf);
			this.textField.defaultTextFormat = tf;
			this.textField.text = this.textField.text;
		}
		
		public function set maxChars(val:int):void {
			this.textField.maxChars = val;
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			this.textField.width = value - textField.x;
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			this.textField.height = value - textField.y;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function initTextField(text:String = ''):void {
			textField = new TextField();
			textField.selectable = textField.tabEnabled = textField.mouseWheelEnabled = textField.mouseEnabled = textField.doubleClickEnabled = false;
			textField.multiline = false;
			setFont(JFont.FONT_LABEL);
			textField.filters = Filter.BLACK;
			this.text = text;
			this.addChild(textField);
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.textField.addEventListener(Event.CHANGE, onTextChanged);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.textField.removeEventListener(Event.CHANGE, onTextChanged);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected function onTextChanged(e:Event):void {
			this.dispatchEvent(e);
		}
	}

}