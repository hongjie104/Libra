package org.libra.utils
{
	import flash.utils.flash_proxy;

	public final class DateUtil
	{
		public function DateUtil()
		{
		}
		
		public static function toString(date:Date):String{
			var year:int = date.fullYear;
			var month:int = date.month + 1;
			var dateInt:int = date.date;
			var monthStr:String = month.toString();
			if(month < 10) monthStr = "0" + monthStr;
			var dateStr:String = dateInt.toString();
			if(dateInt < 10) dateStr = "0" + dateStr;
			return date.fullYear + "-" + monthStr + "-" + dateStr;
		}
	}
}