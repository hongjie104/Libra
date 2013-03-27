package org.libra.ui.starling.core {
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * <p>
	 * 文本组件的父类
	 * </p>
	 *
	 * @class BaseText
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseText extends Component {
		
		/**
		 * 传统显示列表中的TextField
		 * 被赋予文本，然后被渲染成starling所需的Texture
		 * 赋值给显示对象
		 * @private
		 */
		protected var helpTextField:TextField;
		
		/**
		 * 文本内容
		 * @private
		 */
		protected var text:String;
		
		/**
		 * html格式的文本内容
		 * @private
		 */
		protected var htmlText:String;
		
		/**
		 * 是否自动换行
		 * @private
		 * @default false
		 */
		protected var wordWrap:Boolean;
		
		/**
		 * 文本的滤镜
		 * 用在传统的TextField中，然后重新渲染
		 * @private
		 */
		protected var textFilter:Array;
		
		/**
		 * 文本的水平对齐方式
		 * 有三个值：left，center，right
		 * @private
		 * @default left
		 */
		protected var textAlign:String;
		
		/**
		 * 文本的横坐标
		 * 用来调整文本在组件上的位置
		 * @private
		 */
		protected var textX:int;
		
		/**
		 * 文本的纵坐标
		 * 用来调整文本在组件上的位置
		 * @private
		 */
		protected var textY:int;
		
		/**
		 * 显示文本的对象
		 * @private
		 */
		protected var textImage:Image;
		
		/**
		 * 绘制传统TextField的BitmapData
		 * 由他可以得到staring所需的texture
		 * @private
		 */
		protected var textBmd:BitmapData;
		
		/**
		 * 构造函数
		 * @private
		 * @param	widht
		 * @param	height
		 * @param	x
		 * @param	y
		 * @param	text
		 */
		public function BaseText(widht:int, height:int, x:int = 0, y:int = 0, text:String = '') { 
			super(widht, height, x, y);
			quickHitAreaEnabled = true;
			textAlign = 'left';
			helpTextField = new TextField();
			this.setText(text);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 获取文本内容
		 * @return 字符串
		 */
		public function getText():String {
			return this.text;
		}
		
		/**
		 * 设置文本内容
		 * @param	val 字符串
		 */
		public function setText(val:String):void {
			if (text != val) {
				this.text = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 追加文本
		 * @param	text 字符串
		 */
		public function appendText(text:String):void {
			this.text += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取html格式的文本内容
		 * @return html格式的字符串
		 */
		public function getHtmlText():String {
			return this.htmlText;
		}
		
		/**
		 * 设置html文本
		 * @param	val html格式的字符串
		 */
		public function setHtmlText(val:String):void {
			if (htmlText != val) {
				this.htmlText = val;
				this.invalidate(InvalidationFlag.TEXT);	
			}
		}
		
		/**
		 * 追加html文本内容
		 * @param	text html格式的字符串
		 */
		public function appendHtmlText(text:String):void {
			this.htmlText += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 设置字体
		 * @param	font
		 * @see org.libra.ui.flash.theme.JFont
		 */
		public function setFont(font:JFont):void {
			if (helpTextField.defaultTextFormat != font.getTextFormat()) {
				helpTextField.defaultTextFormat = font.getTextFormat();
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本是否自动换行
		 * @param	val 布尔值
		 */
		public function setWordWrap(val:Boolean):void {
			if (this.wordWrap != val) {
				this.wordWrap = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本的滤镜
		 * @param	filter
		 */
		public function setTextFilter(filter:Array):void {
			if (this.textFilter != filter) {
				this.textFilter = filter;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本的水平对齐方式
		 * @param	val
		 */
		public function setTextAlign(val:String):void {
			if (this.textAlign != val) {
				this.textAlign = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本在组件中的坐标
		 * @param	x
		 * @param	y
		 */
		public function setTextLocation(x:int, y:int):void {
			if (textX != x || textY != y) {
				this.textX = x;
				this.textY = y;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 销毁
		 */
		override public function dispose():void {
			super.dispose();
			if (textBmd) {
				this.textBmd.dispose();
				this.textBmd = null;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			if (helpTextField.width != actualWidth || helpTextField.height != actualHeight) {
				helpTextField.width = actualWidth;
				helpTextField.height = actualHeight;
				if (this.textBmd) textBmd.dispose();
				textBmd = new BitmapData(actualWidth, actualHeight, true, 0);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshText():void {
			helpTextField.wordWrap = this.wordWrap;
			helpTextField.filters = this.textFilter;
			//抗锯齿
			helpTextField.antiAliasType = AntiAliasType.ADVANCED;
			
			var tf:TextFormat = helpTextField.defaultTextFormat;
			tf.align = this.textAlign;
			helpTextField.defaultTextFormat = tf;
			
			if (text) helpTextField.text = this.text;
			else if (htmlText) helpTextField.htmlText = this.htmlText;
			else {
				helpTextField.text = '';
			}
			
			this.textBmd.fillRect(textBmd.rect, 0x00000000);
			this.textBmd.draw(helpTextField, new Matrix(1, 0, 0, 1, 0, ((actualHeight - helpTextField.textHeight) >> 1) - 2));
			//text = htmlText = '';
			var texture:Texture = Texture.fromBitmapData(textBmd, false, false, Starling.contentScaleFactor);
			if (this.textImage) {
				textImage.texture.dispose();
				textImage.texture = texture;
				textImage.readjustSize();
			}else {
				textImage = new Image(texture);
                textImage.touchable = false;
                addChild(textImage);
			}
			textImage.x = textX;
			textImage.y = textY;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}