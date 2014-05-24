package org.libra.utils
{
	public class Formatter
	{
		/**
		 * DateFormat 格式化Date
		 * 
		 * @param o       要格式化的Date对象实例
		 * @param format  格式化模板.支持"YYYY YY MMMM MMM MM M DD D EEEE EEE EE E A L HH:NN:SS".可选.默认值:"YYYY-MM-DD HH:NN:SS".
		 */
		public static function DateFormat(o:Date,format:String="YYYY-MM-DD HH:NN:SS"):String
		{
			var reStr:String="";
			var months:Array = ["January","February","March","May","June","July","August","September","October","November","December"];
			var weeks:Array = ["Sunday","Monday","TuesDay","Wednesday","Thursday","Friday","Saturday"];
			var _y:String = o.getFullYear().toString();
			var _m:Number = o.getMonth();
			var _mb:String = _m<10?"0"+(_m+1):(_m+1).toString();
			var _d:Number = o.getDate();
			var _db:String = _d<10?"0"+_d:_d.toString();
			var _h:Number = o.getHours();
			var _hb:String = _h<10?"0"+_h:_h.toString();
			var _n:Number = o.getMinutes();
			var _nb:String = _n<10?"0"+_n:_n.toString();
			var _s:Number = o.getSeconds();
			var _sb:String = _s < 10 ? '0' + _s : _s.toString();
			var _e:Number = o.getDay();
			var _eb:String = "0"+(_e+1);
			reStr = format;
			reStr = reStr.replace(/YYYY/g,_y);
			reStr = reStr.replace(/YY/g,_y.slice(-2));
			reStr = reStr.replace(/MMMM/g,months[_m]);
			reStr = reStr.replace(/MMM/g,months[_m].substr(0,3));
			reStr = reStr.replace(/MM/g,_mb);
			reStr = reStr.replace(/M/g,_m+1);
			reStr = reStr.replace(/DD/g,_db);
			reStr = reStr.replace(/D/g,_d);
			reStr = reStr.replace(/A/g,_h<12?"AM":"PM");
			reStr = reStr.replace(/HH/g,_hb);
			reStr = reStr.replace(/L/g,_h%12);
			reStr = reStr.replace(/NN/g,_nb);
			reStr = reStr.replace(/SS/g,_sb);
			reStr = reStr.replace(/EEEE/g,weeks[_e]);
			reStr = reStr.replace(/EEE/g,weeks[_e].substr(0,3));
			reStr = reStr.replace(/EE/g,_eb);
			reStr = reStr.replace(/E/g,(_e+1));
			return reStr;
		}
		
		/**
		 * 格式化秒数.适合格式化播放器时间等
		 * 
		 * @param t       要格式化的秒数
		 * @param showHours  当小于1小时时是否现实小时数.默认true.可选
		 */
		public static function TimeFormart(t:int,showHours:Boolean = true):String
		{
			t=t<0?0:t;
			var _h:Number = Math.floor(t/3600);
			var _n:Number = Math.floor(t%3600/60);
			var _s:Number = Math.floor((t-60*_n-_h*3600));
			var hh:String = _h<10 ? "0"+_h : _h.toString();
			var nn:String = _n<10 ? "0"+_n : _n.toString();
			var ss:String = _s<10 ? "0"+_s : _s.toString();
			if (hh == "00" && showHours==false) {
				return nn+":"+ss;
			}
			return hh+":"+nn+":"+ss;
		}
		/**
		 * 百分比格式化.用于进度类的计算
		 * @param current    当前量
		 * @param total      总量
		 * @param precision  精度.默认值100.可选;
		 */
		public static function percentFormart(current:uint,total:uint,precision:uint=100):uint{
			var reNum:uint;
			if(total<=0){
				return null;
			}
			reNum = Math.floor(current/total*precision);
			return reNum;
		}
	}
}