package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.libra.ui.flash.theme.DefaultTextTheme;
	import org.libra.ui.flash.theme.JFont;
	
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
		 * @private
		 */
		protected var textField:TextField;
		
		/**
		 * 主题
		 * @private
		 */
		protected var theme:DefaultTextTheme;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 文本内容
		 */
		public function BaseText(theme:DefaultTextTheme, x:int = 0, y:int = 0, text:String = '') { 
			super(x, y);
			this.theme = theme;
			this.initTextField(text);
			this.setSize(theme.width, theme.height);
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
		
		/**
		 * 追加文本内容
		 * @param	text 文本
		 */
		public function appendText(text:String):void {
			this.textField.appendText(text);
		}
		
		/**
		 * 设置文本在控件里的相对坐标
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 */
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
		
		/**
		 * 设置文本
		 */
		public function set text(text:String):void {
			this.textField.text = text;
		}
		
		/**
		 * 获取文本
		 */
		public function get text():String {
			return this.textField.text;
		}
		
		/**
		 * 设置html格式的文本
		 */
		public function set htmlText(text:String):void {
			this.textField.htmlText = text;
		}
		
		/**
		 * 获取html格式的文本
		 */
		public function get htmlText():String {
			return this.textField.htmlText;
		}
		
		/**
		 * 获取文本长度
		 */
		public function get textLength():int {
			return this.textField.length;
		}
		
		/**
		 * 设置文本是否自动换行，当文本内容超过文本宽度时
		 */
		public function set wordWrap(val:Boolean):void {
			this.textField.wordWrap = val;
		}
		
		/**
		 * 设置文本的字体颜色
		 */
		public function set textColor(color:int):void {
			this.textField.textColor = color;
		}
		
		/**
		 * 设置文本的滤镜
		 */
		public function set textFilter(filter:Array):void {
			this.textField.filters = filter;
		}
		
		/**
		 * 设置文本自动对齐的格式
		 * 三种:'left','center','right'
		 */
		public function set textAlign(val:String):void {
			var tf:TextFormat = this.textField.defaultTextFormat;
			tf.align = val;
			this.textField.setTextFormat(tf);
			this.textField.defaultTextFormat = tf;
			this.textField.text = this.textField.text;
		}
		
		/**
		 * 设置文本的最大字数
		 */
		public function set maxChars(val:int):void {
			this.textField.maxChars = val;
		}
		
		/**
		 * 设置文本的宽度
		 */
		override public function set width(value:Number):void {
			super.width = value;
			this.textField.width = value - textField.x;
		}
		
		/**
		 * 设置文本的高度
		 */
		override public function set height(value:Number):void {
			super.height = value;
			this.textField.height = value - textField.y;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 初始化文本
		 * 某些子类需要个性化的文本时可以重写这个方法
		 * @private
		 * @param	text 文本的内容
		 * @default ''
		 */
		protected function initTextField(text:String = ''):void {
			textField = new TextField();
			textField.selectable = textField.mouseWheelEnabled = textField.mouseEnabled = textField.doubleClickEnabled = false;
			textField.multiline = false;
			setFont(theme.font);
			textField.filters = theme.filter;
			this.text = text;
			this.addChild(textField);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this.textField.addEventListener(Event.CHANGE, onTextChanged);
		}
		
		/**
		 * @inheritDoc
		 */
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