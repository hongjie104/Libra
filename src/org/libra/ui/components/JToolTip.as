package org.libra.ui.components {
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextFieldAutoSize;
	import org.libra.ui.style.Style;
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
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function setSize(w:int, h:int):void {
			this.$width = w;
			this.$height = h;
			invalidate();
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
			textField.textColor = Style.TOOLTIP_TEXT;
			setTextLocation(5, 6);
		}
		
		override protected function render():void {
			super.render();
			if (this.background) {
				if (this.background is Bitmap) (background as Bitmap).bitmapData.dispose();
			}
			if($width > 0 && $height > 0)
				this.setBackground(new Bitmap(BitmapDataUtil.getScaledBitmapData(new toolTipBg(), 
					$width, $height, new Rectangle(5, 4, 1, 20))));
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
class Singleton{}