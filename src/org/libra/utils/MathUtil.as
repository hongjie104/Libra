package org.libra.utils {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class MathUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public final class MathUtil {
		
		public function MathUtil() {
			throw new Error('MathUtil不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public static function min(a:Number, b:Number):Number {
			return a > b ? b : a;
		}
		
		public static function max(a:Number, b:Number):Number {
			return a > b ? a : b;
		}
		
		public function confine(value:Number, min:Number, max:Number):Number { 
			return value < min ? min : (value > max ? max : value);
		}
		
		/**
		 * Returns a random int number within a given range
		 * @param	min
		 * @param	max
		 * @return
		 */
		public function randomRangeInt(min:Number, max:Number):Number {
			return Math.floor(Math.random() * (max - min + 1) + min);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}