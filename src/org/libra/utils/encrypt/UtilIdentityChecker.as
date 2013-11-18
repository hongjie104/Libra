package org.libra.utils.encrypt {
	
    public class UtilIdentityChecker {
		
        private static const COEFFICIENT:Array = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
        private static const AUTH:Array = [1, 0, "x", 9, 8, 7, 6, 5, 4, 3, 2];
        private static const DIVIDER:int = 11; 
        private static const LENGTH:int = 17;
		
		/**
		 * 检验身份证号码是否合法
		 * @param	id
		 * @return
		 */
        public static function check(id:String):int { 
			id = id.toLowerCase();
			var re:RegExp = new RegExp("^([0-9]{6})([0-9]{4})([0-9]{2})([0-9]{2})([0-9]{3})([0-9]|x)_", "g");
			var ret:Array = re.exec(id);
			if ( null == ret ) { 
				return 1;
			}
			var month:int = parseInt(ret[3]);
			if ( month < 1 || month > 12 ) { 
				return 5;
			}
			var day:int = parseInt(ret[4]);
			if ( day < 1 || day > 31 ) { 
				return 2;
			}
            var list:Array = id.match(/\d{1}/g);
            if (list.length < LENGTH || id.length != LENGTH + 1) { 
				return 6;
			}
            var sum:int = 0;            
            for (var i:int = 0; i < LENGTH; i++ ) { 
                sum += list[i] * COEFFICIENT[i];
            }
            var mode:int = sum % DIVIDER;            
            if (!(String(AUTH[mode]).toLowerCase() == id.charAt(id.length - 1).toLowerCase())) { 
                return 4;
			}
			var dd:Date = new Date();
			if ( ( dd.fullYear - parseInt(ret[2]) ) < 18 ) { 
					return 3;
			}
            return 0;
        }
    }
}
