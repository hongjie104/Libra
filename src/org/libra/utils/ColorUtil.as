package org.libra.utils
{
	public final class ColorUtil
	{
		
		/**ARGB转10进制*/
		public static function argbToNumber(a:Number, r:Number, g:Number, b:Number):uint
		{
			return a<<24 | r<<16 | g<<8 | b;
		}
		/**RGB转10进制*/
		public static function rgbToNumber(r:Number, g:Number, b:Number):uint
		{
			return r<<16 | g<<8 | b;
		}
		/**10进制转ARGB*/
		public static function numberToArgb(val:Number):Object
		{
			var col:Object = {};
			col.alpha = (val >> 24) & 0xFF;
			col.red = (val >> 16) & 0xFF;
			col.green = (val >> 8) & 0xFF;
			col.blue = val & 0xFF;
			return col;
		}
		/**10进制转RGB*/
		public static function numberToRgb(val:Number):Object
		{
			var col:Object = {};
			col.red = (val >> 16) & 0xFF;
			col.green = (val >> 8) & 0xFF;
			col.blue = val & 0xFF;
			return col;
		}
	}
}