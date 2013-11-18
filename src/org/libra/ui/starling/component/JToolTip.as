package org.libra.ui.starling.component {
	import flash.geom.Matrix;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import org.libra.ui.flash.theme.Filter;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.starling.theme.DefaultTheme;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JToolTip
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/04/2012
	 * @version 1.0
	 * @see
	 */
	public class JToolTip extends JLabel {
		
		private static var _instance:JToolTip;
		
		public function JToolTip(singleton:Singleton) {
			super(1, 20);
			setTextLocation(2, 2);
			font = JFont.FONT_TOOL_TIP;
			textFilter = Filter.BLACK;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function get instance():JToolTip {
			return _instance ||= new JToolTip(new Singleton());
		}
		
		override public function invalidate(flag:int = -1):void {
			super.invalidate();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			this.setBackground(new JScale9Sprite(DefaultTheme.instance.getScale9Texture(DefaultTheme.TOOL_TIP)));
		}
		
		override protected function refreshText():void {
			//当文本更新后，取得文本最小宽度，先改变控件宽度，然后再绘制文本
			if (text) _helpTextField.text = text;
			else if (htmlText) _helpTextField.htmlText = htmlText;
			else return;
			_helpTextField.autoSize = TextFieldAutoSize.LEFT;
			
			//textWidth得到的宽度，是文本的宽，
			//背景的话，还得再加上一些值，使得左右两边能够空出一些，这样更美观一些
			//12这个值，目测刚刚好。
			this._actualWidth = _helpTextField.textWidth + 12;
			this._actualHeight = _helpTextField.height;
			_hitArea.width = width;
			_hitArea.height = height;
			resize();
		}
		
		override protected function resize():void {
			if (_helpTextField.width != _actualWidth || _helpTextField.height != _actualHeight) {
				super.resize();	
				_background.width = _actualWidth;
				_background.height = _actualHeight;
			}
			
			//宽高改变后，需要重新绘制文本内容
			_helpTextField.wordWrap = this._wordWrap;
			_helpTextField.filters = this._textFilter;
			//抗锯齿
			_helpTextField.antiAliasType = AntiAliasType.ADVANCED;
			
			var tf:TextFormat = _helpTextField.defaultTextFormat;
			tf.align = this._textAlign;
			_helpTextField.defaultTextFormat = tf;
			
			this._textBmd.fillRect(_textBmd.rect, 0x00000000);
			this._textBmd.draw(_helpTextField, new Matrix(1, 0, 0, 1, 2, ((_actualHeight - _helpTextField.textHeight) >> 1) - 2));
			var texture:Texture = Texture.fromBitmapData(_textBmd, false, false, Starling.contentScaleFactor);
			if (this._textImage) {
				_textImage.texture.dispose();
				_textImage.texture = texture;
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
final class Singleton{}