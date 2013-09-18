package org.libra.ui.flash.core {
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.flash.theme.DefaultTextTheme;
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
		protected var $textField:TextField;
		
		protected var $text:String;
		
		protected var $htmlText:String;
		
		/**
		 * 主题
		 * @private
		 */
		protected var $theme:DefaultTextTheme;
		
		/**
		 * 是否使用默认的滤镜
		 * @private
		 * @default true
		 */
		protected var $defaultFilter:Boolean;
		
		/**
		 * 构造函数
		 * @param	x 横坐标
		 * @param	y 纵坐标
		 * @param	text 文本内容
		 */
		public function BaseText(theme:DefaultTextTheme = null, x:int = 0, y:int = 0, text:String = '') { 
			super(x, y);
			this.$theme = theme ? theme : UIManager.getInstance().theme.textFieldTheme;
			this.initTextField(text);
			this.setSize($theme.width, $theme.height);
			$htmlText = '';
			$defaultFilter = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override public function setSize(w:int, h:int):void {
			super.setSize(w, h);
			this.$textField.width = w - $textField.x;
			this.$textField.height = h - $textField.y;
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
			this.$textField.x = x;
			this.$textField.y = y;
			this.$textField.width = $actualWidth - x;
			this.$textField.height = $actualHeight - y;
		}
		
		/**
		 * 设置文本框中，被选中的文本段
		 * @param	beginIndex 选中文本第一个字符的索引值
		 * @param	endIndex选中文本最后一个字符的索引值
		 */
		public function setSelection(beginIndex:int, endIndex:int):void {
			this.$textField.setSelection(beginIndex, endIndex);
		}
		
		/**
		 * 设置文本字体，每次将Textfield的text重置时，Textfield都会将其TextFormat设置为默认的TextFormat，
		 * 所以该方法修改的不仅仅是Textfield的TextFormat，还有defaultTextFormat
		 * @param	font
		 */
		public function setFont(font:JFont):void {
			const newTf:TextFormat = font.getTextFormat();
			newTf.align = this.textAlign;
			this.$textField.setTextFormat(newTf);
			this.$textField.defaultTextFormat = newTf;
		}
		
		/**
		 * 多行显示时，设置行间距
		 * @param	value
		 */
		//public function setLeading(value:int):void {
			//var tf:TextFormat = this.$textField.defaultTextFormat;
			//var newTf:TextFormat = new TextFormat();
			//newTf.leading = value;
			//如果有旧的TextFormat，那么将其对齐方式赋值给新的TextFormat
			//if (tf) {
				//newTf.align = tf.align;
				//newTf.font = tf.font;
			//}
			//this.$textField.setTextFormat(newTf);
			//this.$textField.defaultTextFormat = newTf;
		//}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setter
		-------------------------------------------------------------------------------------------*/
		
		public function set theme(theme:DefaultTextTheme):void {
			$theme = theme;
			this.invalidate(InvalidationFlag.STYLE);
		}
		
		/**
		 * 设置文本
		 */
		public function set text(text:String):void {
			$text = text;
			if ($text) $htmlText = '';
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取文本
		 */
		public function get text():String {
			$text = $textField.text;
			return $text
		}
		
		/**
		 * 设置html格式的文本
		 */
		public function set htmlText(text:String):void {
			$htmlText = text;
			if ($htmlText) $text = '';
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取html格式的文本
		 */
		public function get htmlText():String {
			return $htmlText;
		}
		
		/**
		 * 获取文本长度
		 */
		public function get textLength():int {
			return this.$textField.length;
		}
		
		/**
		 * 设置文本是否自动换行，当文本内容超过文本宽度时
		 */
		public function set wordWrap(val:Boolean):void {
			this.$textField.wordWrap = val;
		}
		
		public function get wordWrap():Boolean {
			return $textField.wordWrap;
		}
		
		/**
		 * 设置文本的字体颜色
		 */
		public function set textColor(color:uint):void {
			this.$textField.textColor = color;
		}
		
		public function get textColor():uint {
			return $textField.textColor;
		}
		
		/**
		 * 设置文本的滤镜
		 */
		public function set textFilter(filter:Array):void {
			this.$textField.filters = filter;
		}
		
		public function get textFilter():Array {
			return $textField.filters;
		}
		
		/**
		 * 设置文本自动对齐的格式
		 * 三种:'left','center','right'
		 */
		public function set textAlign(val:String):void {
			var tf:TextFormat = this.$textField.defaultTextFormat;
			tf.align = val;
			this.$textField.setTextFormat(tf);
			this.$textField.defaultTextFormat = tf;
		}
		
		public function get textAlign():String {
			return $textField.defaultTextFormat.align;
		}
		
		/**
		 * 设置文本的最大字数
		 */
		public function set maxChars(val:int):void {
			this.$textField.maxChars = val;
		}
		
		/**
		 * 设置文本的宽度
		 */
		override public function set width(value:Number):void {
			super.width = value;
			this.$textField.width = value - $textField.x;
		}
		
		/**
		 * 设置文本的高度
		 */
		override public function set height(value:Number):void {
			super.height = value;
			this.$textField.height = value - $textField.y;
		}
		
		public function get font():String {
			return this.$textField.defaultTextFormat.font;
		}
		
		public function set font(val:String):void {
			const tf:TextFormat = this.$textField.defaultTextFormat;
			tf.font = val;
			this.$textField.defaultTextFormat = tf;
			this.$textField.setTextFormat(tf);
		}
		
		public function get fontSize():int {
			return int(this.$textField.defaultTextFormat.size);
		}
		
		public function set fontSize(val:int):void {
			const tf:TextFormat = this.$textField.defaultTextFormat;
			tf.size = val;
			this.$textField.defaultTextFormat = tf;
			this.$textField.setTextFormat(tf);
		}
		
		public function get fontBold():Boolean {
			return this.$textField.defaultTextFormat.bold;
		}
		
		public function set fontBold(val:Boolean):void {
			const tf:TextFormat = this.$textField.defaultTextFormat;
			tf.bold = val;
			this.$textField.defaultTextFormat = tf;
			this.$textField.setTextFormat(tf);
		}
		
		public function get defaultFilter():Boolean {
			return $defaultFilter;
		}
		
		public function set defaultFilter(value:Boolean):void {
			$defaultFilter = value;
			this.textFilter = $defaultFilter ? Filter.BLACK : null;
		}
		
		override public function clone():Component {
			return new BaseText($theme, x, y, $text);
		}
		
		override public function toXML():XML {
			const tmpAry:Array = getQualifiedClassName(this).split('::');
			return new XML('<' + tmpAry[tmpAry.length - 1] + ' ' + 
							(x ? 'x="' + x + '" ' : '') + 
							(y ? 'y="' + y + '" ' : '') + 
							($actualWidth ? 'width="' + $actualWidth + '" ' : '') + 
							($actualHeight ? 'height="' + $actualHeight + '" ' : '') + 
							($enabled ? '' : 'enabled="false" ') + 
							($toolTipText ? 'toolTipText="' + $toolTipText + '" ' : '') + 
							($textField.wordWrap ? 'wordWrap="true" ' : '') + 
							($text ? 'text="' + $text + '" ' : '') + 
							($htmlText ? 'htmlText="' + $htmlText + '" ' : '') + 
							'textColor="' + $textField.textColor + '" ' + 
							'textAlign="' + $textField.defaultTextFormat.align + '" ' + 
							(font != 'simsun' ? 'font="' + font + '" ' : '') + 
							(fontSize != 12 ? 'fontSize="' + fontSize + '" ' : '') + 
							(fontBold ? 'fontBold="true" ' : '') + 
							(!$defaultFilter ? 'defaultFilter="false" ' : '') + 
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
			$textField = new TextField();
			$textField.selectable = $textField.mouseWheelEnabled = $textField.mouseEnabled = $textField.doubleClickEnabled = false;
			$textField.multiline = false;
			setFont($theme.font);
			$textField.filters = $theme.filter;
			this.text = text;
			this.addChild($textField);
		}
		
		override protected function refreshText():void {
			$textField.text = $text ? $text : $htmlText;
		}
		
		override protected function refreshStyle():void {
			this.setSize($theme.width, $theme.height);
			setFont($theme.font);
			$textField.filters = $theme.filter;
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
			this.$textField.addEventListener(Event.CHANGE, onTextChanged);
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			this.$textField.removeEventListener(Event.CHANGE, onTextChanged);
		}
	}

}