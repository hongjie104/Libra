package org.libra.utils {
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Beizer
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/23/2012
	 * @version 1.0
	 * @see
	 */
	public final class Beizer {
		
		public function Beizer() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function getBeizerPoint(arr:Array, per:Number):Point { 
			const n:int = arr.length;
			switch(n) { 
                case 0:
					return null;
					break;
				case 1 :
					return arr[0];
					break;
				case 2 :
					return Point.interpolate(arr[0], arr[1], per);
					break;
				default :
					const newArr:Array = [];
					for (var i:int = 0; i < n - 1; i++) { 
						newArr[i] = Point.interpolate(arr[i], arr[i + 1], per);
					}
					return getBeizerPoint(newArr, per);
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}