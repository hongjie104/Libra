package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import org.libra.ui.flash.theme.JFont;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.ui.managers.UIManager;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.BitmapDataUtil;
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
		
		private static var instance:JLabel;
		
		public function JToolTip(singleton:Singleton) {
			super(UIManager.getInstance().theme.labelTheme);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			this.actualWidth = w;
			this.actualHeight = h;
			invalidate(InvalidationFlag.SIZE);
		}
		
		public static function getInstance():JLabel {
			return instance ||= new JToolTip(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters and setters
		-------------------------------------------------------------------------------------------*/
		
		override public function set text(value:String):void {
			super.text = value;
			this.textField.autoSize = TextFieldAutoSize.LEFT;
			this.setSize(textField.textWidth + 13, 29);
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
			if (this.background) {
				if (this.background is Bitmap) {
					const bitmap:Bitmap = background as Bitmap;
					if (bitmap.bitmapData) bitmap.bitmapData.dispose();
				}
			}
			if(actualWidth > 0 && actualHeight > 0)
				this.setBackground(new Bitmap(BitmapDataUtil.getScale9BitmapData(ResManager.getInstance().getBitmapData('toolTipBg'), 
					actualWidth, actualHeight, new Rectangle(5, 4, 1, 20))));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
final class Singleton{}