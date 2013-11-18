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
		protected var _helpTextField:TextField;
		
		/**
		 * 文本内容
		 * @private
		 */
		protected var _text:String;
		
		/**
		 * html格式的文本内容
		 * @private
		 */
		protected var _htmlText:String;
		
		/**
		 * 是否自动换行
		 * @private
		 * @default false
		 */
		protected var _wordWrap:Boolean;
		
		/**
		 * 文本的滤镜
		 * 用在传统的TextField中，然后重新渲染
		 * @private
		 */
		protected var _textFilter:Array;
		
		/**
		 * 文本的水平对齐方式
		 * 有三个值：left，center，right
		 * @private
		 * @default left
		 */
		protected var _textAlign:String;
		
		/**
		 * 文本的横坐标
		 * 用来调整文本在组件上的位置
		 * @private
		 */
		protected var _textX:int;
		
		/**
		 * 文本的纵坐标
		 * 用来调整文本在组件上的位置
		 * @private
		 */
		protected var _textY:int;
		
		/**
		 * 显示文本的对象
		 * @private
		 */
		protected var _textImage:Image;
		
		/**
		 * 绘制传统TextField的BitmapData
		 * 由他可以得到staring所需的texture
		 * @private
		 */
		protected var _textBmd:BitmapData;
		
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
			_textAlign = 'left';
			_helpTextField = new TextField();
			this.text = text;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 获取文本内容
		 * @return 字符串
		 */
		public function get text():String {
			return this._text;
		}
		
		/**
		 * 设置文本内容
		 * @param	val 字符串
		 */
		public function set text(val:String):void {
			if (_text != val) {
				this._text = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 追加文本
		 * @param	text 字符串
		 */
		public function appendText(text:String):void {
			this._text += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 获取html格式的文本内容
		 * @return html格式的字符串
		 */
		public function get htmlText():String {
			return this._htmlText;
		}
		
		/**
		 * 设置html文本
		 * @param	val html格式的字符串
		 */
		public function set htmlText(val:String):void {
			if (_htmlText != val) {
				this._htmlText = val;
				this.invalidate(InvalidationFlag.TEXT);	
			}
		}
		
		/**
		 * 追加html文本内容
		 * @param	text html格式的字符串
		 */
		public function appendHtmlText(text:String):void {
			this._htmlText += text;
			this.invalidate(InvalidationFlag.TEXT);
		}
		
		/**
		 * 设置字体
		 * @param	font
		 * @see org.libra.ui.flash.theme.JFont
		 */
		public function set font(font:JFont):void {
			if (_helpTextField.defaultTextFormat != font.getTextFormat()) {
				_helpTextField.defaultTextFormat = font.getTextFormat();
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本是否自动换行
		 * @param	val 布尔值
		 */
		public function set wordWrap(val:Boolean):void {
			if (this._wordWrap != val) {
				this._wordWrap = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本的滤镜
		 * @param	filter
		 */
		public function set textFilter(filter:Array):void {
			if (this._textFilter != filter) {
				this._textFilter = filter;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本的水平对齐方式
		 * @param	val
		 */
		public function set textAlign(val:String):void {
			if (this._textAlign != val) {
				this._textAlign = val;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 设置文本在组件中的坐标
		 * @param	x
		 * @param	y
		 */
		public function setTextLocation(x:int, y:int):void {
			if (_textX != x || _textY != y) {
				this._textX = x;
				this._textY = y;
				this.invalidate(InvalidationFlag.TEXT);
			}
		}
		
		/**
		 * 销毁
		 */
		override public function dispose():void {
			super.dispose();
			if (_textBmd) {
				this._textBmd.dispose();
				this._textBmd = null;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * @inheritDoc
		 */
		override protected function resize():void {
			if (_helpTextField.width != _actualWidth || _helpTextField.height != _actualHeight) {
				_helpTextField.width = _actualWidth;
				_helpTextField.height = _actualHeight;
				if (this._textBmd) _textBmd.dispose();
				_textBmd = new BitmapData(_actualWidth, _actualHeight, true, 0);
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function refreshText():void {
			_helpTextField.wordWrap = this._wordWrap;
			_helpTextField.filters = this._textFilter;
			//抗锯齿
			_helpTextField.antiAliasType = AntiAliasType.ADVANCED;
			
			var tf:TextFormat = _helpTextField.defaultTextFormat;
			tf.align = this._textAlign;
			_helpTextField.defaultTextFormat = tf;
			
			if (_text) _helpTextField.text = this._text;
			else if (_htmlText) _helpTextField.htmlText = this._htmlText;
			else {
				_helpTextField.text = '';
			}
			
			this._textBmd.fillRect(_textBmd.rect, 0x00000000);
			this._textBmd.draw(_helpTextField, new Matrix(1, 0, 0, 1, 0, ((_actualHeight - _helpTextField.textHeight) >> 1) - 2));
			//text = htmlText = '';
			var texture:Texture = Texture.fromBitmapData(_textBmd, false, false, Starling.contentScaleFactor);
			if (this._textImage) {
				_textImage.texture.dispose();
				_textImage.texture = texture;
				//根据图像当前的纹理调整图像的尺寸，在为图片设置了另外一个不同的纹理以后，需要调用这个方法来同步图像和纹理的尺寸。
				_textImage.readjustSize();
			}else {
				_textImage = new Image(texture);
				_textImage.touchable = false;
                addChild(_textImage);
			}
			_textImage.x = _textX;
			_textImage.y = _textY;
		}
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}