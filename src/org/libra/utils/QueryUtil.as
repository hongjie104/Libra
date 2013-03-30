package org.libra.utils {
	
	/**
	 * ...
	 * @author Eddie
	 */
	public final class QueryUtil {
		
		public function QueryUtil() {
		
		}
		
		/**
		 * 2分发查找
		 * @param	ary
		 * @param	type
		 * @return
		 */
		public static function queryByType(ary:Array, val:int, property:String = 'type'):* {
			if (!ary) return null;
			var leftIndex:int = 0, middleIndex:int = 0;
			var rightIndex:int = ary.length - 1;
			while (rightIndex >= leftIndex) {
				middleIndex = (rightIndex + leftIndex) >> 1;
				if (ary[middleIndex][property] > val) { 
					rightIndex = middleIndex - 1;
				}else {
					leftIndex = middleIndex + 1;
				}
			}
			return ary[leftIndex - 1];
		}
		
	}

}