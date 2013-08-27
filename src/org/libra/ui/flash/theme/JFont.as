package org.libra.ui.flash.theme {
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
	 * @date 10/27/2012
	 * @version 1.0
	 * @see
	 */
	public class JFont {
		
		public static const FONT_INPUT:JFont = new JFont("simsun", 12, 0x333333);
		
		public static const FONT_LABEL:JFont = new JFont('simsun', 12, 0xffffff);
		
		public static const FONT_BTN:JFont = new JFont('simsun', 12, 0xffb932);
		
		public static const FONT_TOOL_TIP:JFont = new JFont('simsun', 12, 0xcccccc);
		
		public static const FONT_12:JFont = new JFont('simsun', 12, 0xffffff);
		
		public static const FONT_12_BOLD:JFont = new JFont('simsun', 12, 0xffffff, true);
		
		public static const FONT_14:JFont = new JFont('simsun', 14, 0xffffff);
		
		public static const FONT_14_BOLD:JFont = new JFont('simsun', 14, 0xffffff, true);
		
		//private static const FONT_LIST:Vector.<JFont> = new Vector.<JFont>;
		
		private var name:String;
		
		private var size:int;
		
		private var color:int;
		
		private var bold:Boolean;
		
		private var italic:Boolean;
		
		private var underline:Boolean;
		
		private var textFormat:TextFormat;
		
		public function JFont(name:String = "simsun", size:int = 12, color:int = 0x000000, bold:Boolean = false, italic:Boolean = false, underline:Boolean = false) {
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
		
		public function getTextFormat():TextFormat {
			return this.textFormat;
		}
		
		public function clone():JFont {
			return new JFont(name, size, color, bold, italic, underline);
		}
		
		public function toString():String{
			return "JFont[" 
				+ "name : " + name 
				+ "color : " + color 
				+ ", size : " + size 
				+ ", bold : " + bold 
				+ ", italic : " + italic 
				+ ", underline : " + underline 
				+ "]";
		}
		
		/*public static function getFont(name:String, size:int, color:int, bold:Boolean, italic:Boolean, underline:Boolean):JFont {
			var i:int = FONT_LIST.length;
			while (--i > -1) {
				if (FONT_LIST[i].name == name) {
					if (FONT_LIST[i].size == size) {
						if (FONT_LIST[i].color == color) {
							if (FONT_LIST[i].bold == bold) {
								if (FONT_LIST[i].italic == italic) {
									if (FONT_LIST[i].underline == underline) {
										return FONT_LIST[i];
									}
								}
							}
						}
					}
				}
			}
			const font:JFont = new JFont(name, size, color, bold, italic, underline);
			FONT_LIST.push(font);
			return font;
		}*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}