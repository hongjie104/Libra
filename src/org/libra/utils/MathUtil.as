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
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}