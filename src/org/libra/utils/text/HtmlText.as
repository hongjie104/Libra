package org.libra.utils.text {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class HtmlText
	 * @author Eddie
	 * @qq 32968210
	 * @date 01-06-2012
	 * @version 1.0
	 * @see
	 */
	public final class HtmlText {
		
		public static const YELLOW:int = 16776960;
		public static const RED:int = 16711680;
		public static const WHITE:int = 16777215;
		public static const GREEN:int = 65280;
		public static const BLUE:int = 255;
		public static const ORANGE:int = 16225309;
		public static const PURPLE:int = 16711935;
		
		public function HtmlText() {
			throw new Error('HtmlText无法实例化');
		}
		
		public static function format(text:String, color:int = 0, fontSize:uint = 12, font:String = "", bold:Boolean = false, italic:Boolean = false, underline:Boolean = false, href:String = null, align:String = null):String {
			if (bold) text = "<b>" + text + "</b>";
			if (italic) text = "<i>" + text + "</i>";
			if (underline) text = "<u>" + text + "</u>";
			var fontStr:String = "";
			if (font) fontStr = fontStr + (" font=\"" + font + "\"");
			if (fontSize > 0) fontStr = fontStr + (" size=\"" + fontSize + "\"");
			fontStr = fontStr + (" color=\"#" + color.toString(16) + "\"");
			text = "<font" + fontStr + ">" + text + "</font>";
			if (href) text = "<a href=\"" + href + "\" target=\"_blank\">" + text + "</a>";
			if (align) text = "<p align=\"" + align + "\">" + text + "</p>";
			return text;
		}
		
	}

}