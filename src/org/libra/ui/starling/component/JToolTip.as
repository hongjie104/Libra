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
		
		private static var instance:JToolTip;
		
		public function JToolTip(singleton:Singleton) {
			super(1, 20);
			setTextLocation(2, 2);
			setFont(JFont.FONT_TOOL_TIP);
			setTextFilter(Filter.BLACK);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function getInstance():JToolTip {
			return instance ||= new JToolTip(new Singleton());
		}
		
		override public function invalidate(flag:int = -1):void {
			super.invalidate();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function init():void {
			super.init();
			this.setBackground(new JScale9Sprite(DefaultTheme.getInstance().getScale9Texture(DefaultTheme.TOOL_TIP)));
		}
		
		override protected function refreshText():void {
			//当文本更新后，取得文本最小宽度，先改变控件宽度，然后再绘制文本
			if (text) helpTextField.text = text;
			else if (htmlText) helpTextField.htmlText = htmlText;
			else return;
			helpTextField.autoSize = TextFieldAutoSize.LEFT;
			
			//textWidth得到的宽度，是文本的宽，
			//背景的话，还得再加上一些值，使得左右两边能够空出一些，这样更美观一些
			//12这个值，目测刚刚好。
			this.actualWidth = helpTextField.textWidth + 12;
			this.actualHeight = helpTextField.height;
			hitArea.width = width;
			hitArea.height = height;
			resize();
		}
		
		override protected function resize():void {
			if (helpTextField.width != actualWidth || helpTextField.height != actualHeight) {
				super.resize();	
				background.width = actualWidth;
				background.height = actualHeight;
			}
			
			//宽高改变后，需要重新绘制文本内容
			helpTextField.wordWrap = this.wordWrap;
			helpTextField.filters = this.textFilter;
			//抗锯齿
			helpTextField.antiAliasType = AntiAliasType.ADVANCED;
			
			var tf:TextFormat = helpTextField.defaultTextFormat;
			tf.align = this.textAlign;
			helpTextField.defaultTextFormat = tf;
			
			this.textBmd.fillRect(textBmd.rect, 0x00000000);
			this.textBmd.draw(helpTextField, new Matrix(1, 0, 0, 1, 2, ((actualHeight - helpTextField.textHeight) >> 1) - 2));
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
final class Singleton{}