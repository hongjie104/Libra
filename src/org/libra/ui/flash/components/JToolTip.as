package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.asset.AssetsStorage;
	import org.libra.utils.displayObject.BitmapDataUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JToolTip
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public class JToolTip extends JLabel {
		
		private static var _instance:JLabel;
		
		public function JToolTip(singleton:Singleton) {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			this._actualWidth = w;
			this._actualHeight = h;
			invalidate(InvalidationFlag.SIZE);
		}
		
		public static function get instance():JLabel {
			return _instance ||= new JToolTip(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		override public function set text(value:String):void {
			_text = value;
			_textField.text = _text;
			this._textField.autoSize = TextFieldAutoSize.LEFT;
			this.setSize(_textField.textWidth + 13, 29);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function initTextField(text:String = ''):void {
			super.initTextField(text);
			setFont(JFont.FONT_LABEL);
			setTextLocation(5, 6);
		}
		
		override protected function resize():void {
			if (this._background) {
				if (this._background is Bitmap) {
					const bitmap:Bitmap = _background as Bitmap;
					if (bitmap.bitmapData) bitmap.bitmapData.dispose();
				}
			}
			if(_actualWidth > 0 && _actualHeight > 0)
				this.background = new Bitmap(BitmapDataUtil.getScale9BitmapData(AssetsStorage.instance.getBitmapData('toolTipBg'), 
					_actualWidth, _actualHeight, new Rectangle(5, 4, 1, 20)));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
final class Singleton{}