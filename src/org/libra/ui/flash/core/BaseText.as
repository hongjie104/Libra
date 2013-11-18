package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.Filter;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	
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
		protected var _textField:TextField;
		
		protected var _text:String;
		
		protected var _htmlText:String;
		
		protected var _font:JFont;
		
		protected var _filters:Array;
		
		/**
		 * 是否使用默认的滤镜
		 * @private
		 * @default true
		 */
		protected var _defaultFilter:Boolean;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 文本内容
		 */
		public function BaseText(x:int = 0, y:int = 0, text:String = '', font:JFont = null, filters:Array = null) { 
			super(x, y);
			this._font = font;
			this._filters = filters;
			this.initTextField(text);
			_htmlText = '';
			_defaultFilter = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			this._textField.width = w - _textField.x;
			this._textField.height = h - _textField.y;
		}
		
		/**
		 * 追加文本内容
		 * @param	text 文本
		 */
		public function appendText(text:String):void {
			this.text += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 设置文本在控件里的相对坐标
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 */
		public function setTextLocation(x:int, y:int):void {
			this._textField.x = x;
			this._textField.y = y;
			this._textField.width = _actualWidth - x;
			this._textField.height = _actualHeight - y;
		}
		
		/**
		 * 设置文本框中，被选中的文本段
		 * @param	beginIndex 选中文本第一个字符的索引值
		 * @param	endIndex选中文本最后一个字符的索引值
		 */
		public function setSelection(beginIndex:int, endIndex:int):void {
			this._textField.setSelection(beginIndex, endIndex);
		}
		
		/**
		 * 设置文本字体，每次将Textfield的text重置时，Textfield都会将其TextFormat设置为默认的TextFormat，
		 * 所以该方法修改的不仅仅是Textfield的TextFormat，还有defaultTextFormat
		 * @param	font
		 */
		public function setFont(font:JFont):void {
			if (!font) font = JFont.FONT_LABEL.clone();
			const newTf:TextFormat = font.getTextFormat();
			newTf.align = this.textAlign;
			this._textField.setTextFormat(newTf);
			this._textField.defaultTextFormat = newTf;
		}
		
		/**
		 * 多行显示时，设置行间距
		 * @param	value
		 */
		//public function setLeading(value:int):void {
			//var tf:TextFormat = this._textField.defaultTextFormat;
			//var newTf:TextFormat = new TextFormat();
			//newTf.leading = value;
			//如果有旧的TextFormat，那么将其对齐方式赋值给新的TextFormat
			//if (tf) {
				//newTf.align = tf.align;
				//newTf.font = tf.font;
			//}
			//this._textField.setTextFormat(newTf);
			//this._textField.defaultTextFormat = newTf;
		//}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置文本
		 */
		public function set text(text:String):void {
			_text = text;
			if (_text) _htmlText = '';
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取文本
		 */
		public function get text():String {
			_text = _textField.text;
			return _text
		}
		
		/**
		 * 设置html格式的文本
		 */
		public function set htmlText(text:String):void {
			_htmlText = text;
			if (_htmlText) _text = '';
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取html格式的文本
		 */
		public function get htmlText():String {
			return _htmlText;
		}
		
		/**
		 * 获取文本长度
		 */
		public function get textLength():int {
			return this._textField.length;
		}
		
		/**
		 * 设置文本是否自动换行，当文本内容超过文本宽度时
		 */
		public function set wordWrap(val:Boolean):void {
			this._textField.wordWrap = val;
		}
		
		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}
		
		/**
		 * 设置文本的字体颜色
		 */
		public function set textColor(color:uint):void {
			this._textField.textColor = color;
		}
		
		public function get textColor():uint {
			return _textField.textColor;
		}
		
		/**
		 * 设置文本的滤镜
		 */
		public function set textFilter(filter:Array):void {
			this._textField.filters = filter;
		}
		
		public function get textFilter():Array {
			return _textField.filters;
		}
		
		/**
		 * 设置文本自动对齐的格式
		 * 三种:'left','center','right'
		 */
		public function set textAlign(val:String):void {
			var tf:TextFormat = this._textField.defaultTextFormat;
			tf.align = val;
			this._textField.setTextFormat(tf);
			this._textField.defaultTextFormat = tf;
		}
		
		public function get textAlign():String {
			return _textField.defaultTextFormat.align;
		}
		
		/**
		 * 设置文本的最大字数
		 */
		public function set maxChars(val:int):void {
			this._textField.maxChars = val;
		}
		
		/**
		 * 设置文本的宽度
		 */
		override public function set width(value:Number):void {
			super.width = value;
			this._textField.width = value - _textField.x;
		}
		
		/**
		 * 设置文本的高度
		 */
		override public function set height(value:Number):void {
			super.height = value;
			this._textField.height = value - _textField.y;
		}
		
		public function get font():String {
			return this._textField.defaultTextFormat.font;
		}
		
		public function set font(val:String):void {
			const tf:TextFormat = this._textField.defaultTextFormat;
			tf.font = val;
			this._textField.defaultTextFormat = tf;
			this._textField.setTextFormat(tf);
		}
		
		public function get fontSize():int {
			return int(this._textField.defaultTextFormat.size);
		}
		
		public function set fontSize(val:int):void {
			const tf:TextFormat = this._textField.defaultTextFormat;
			tf.size = val;
			this._textField.defaultTextFormat = tf;
			this._textField.setTextFormat(tf);
		}
		
		public function get fontBold():Boolean {
			return this._textField.defaultTextFormat.bold;
		}
		
		public function set fontBold(val:Boolean):void {
			const tf:TextFormat = this._textField.defaultTextFormat;
			tf.bold = val;
			this._textField.defaultTextFormat = tf;
			this._textField.setTextFormat(tf);
		}
		
		public function get defaultFilter():Boolean {
			return _defaultFilter;
		}
		
		public function set defaultFilter(value:Boolean):void {
			_defaultFilter = value;
			this.textFilter = _defaultFilter ? Filter.BLACK : null;
		}
		
		override public function clone():Component {
			return new BaseText(x, y, _text, _font, _filters);
		}
		
		override public function toXML():XML {
			const tmpAry:Array = getQualifiedClassName(this).split('::');
			return new XML('<' + tmpAry[tmpAry.length - 1] + ' ' + 
							(x ? 'x="' + x + '" ' : '') + 
							(y ? 'y="' + y + '" ' : '') + 
							(_actualWidth ? 'width="' + _actualWidth + '" ' : '') + 
							(_actualHeight ? 'height="' + _actualHeight + '" ' : '') + 
							(_enabled ? '' : 'enabled="false" ') + 
							(_toolTipText ? 'toolTipText="' + _toolTipText + '" ' : '') + 
							(_textField.wordWrap ? 'wordWrap="true" ' : '') + 
							(_text ? 'text="' + _text + '" ' : '') + 
							(_htmlText ? 'htmlText="' + _htmlText + '" ' : '') + 
							'textColor="' + _textField.textColor + '" ' + 
							'textAlign="' + _textField.defaultTextFormat.align + '" ' + 
							(font != 'simsun' ? 'font="' + font + '" ' : '') + 
							(fontSize != 12 ? 'fontSize="' + fontSize + '" ' : '') + 
							(fontBold ? 'fontBold="true" ' : '') + 
							(!_defaultFilter ? 'defaultFilter="false" ' : '') + 
						   '/>');
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
			_textField = new TextField();
			_textField.selectable = _textField.mouseWheelEnabled = _textField.mouseEnabled = _textField.doubleClickEnabled = false;
			_textField.multiline = false;
			this.setFont(this._font);
			this.textFilter = _filters;
			this.text = text;
			this.addChild(_textField);
		}
		
		override protected function refreshText():void {
			_textField.text = _text ? _text : _htmlText;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		protected function onTextChanged(e:Event):void {
			this.dispatchEvent(e);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			this._textField.addEventListener(Event.CHANGE, onTextChanged);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this._textField.removeEventListener(Event.CHANGE, onTextChanged);
		}
	}

}