package org.libra.ui.utils {
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JFont
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/05/2012
	 * @version 1.0
	 * @see
	 */
	public final class JFont {
		
		public static const FONT_INPUT:JFont = new JFont("simsun", 12, 0x333333);
		
		public static const FONT_LABEL:JFont = new JFont('simsun', 12, 0xffffff);
		
		public static const FONT_BTN:JFont = new JFont('simsun', 12, 0xffb932);
		
		private var name:String;
		private var size:int;
		private var color:int;
		private var bold:Boolean;
		private var italic:Boolean;
		private var underline:Boolean;
		private var textFormat:TextFormat;
		
		public function JFont(name:String = "simsun", size:int = 12, color:int = 0x000000, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false) {
			this.name = name;
			this.size = size;
			this.color = color;
			this.bold = bold;
			this.italic = italic;
			this.underline = underline;
			textFormat = new TextFormat(name, size, color, bold, italic, underline, "", "", TextFormatAlign.LEFT, 0, 0, 0, 5);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getTextFormat():TextFormat{
			return this.textFormat;
		}
		
		public function toString():String{
			return "JFont[" 
				+ "name : " + name 
				+ ", size : " + size 
				+ ", bold : " + bold 
				+ ", italic : " + italic 
				+ ", underline : " + underline 
				+ "]";
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}