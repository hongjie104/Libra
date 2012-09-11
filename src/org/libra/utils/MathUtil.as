package org.libra.utils {
	import flash.geom.Point;
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
		
		static public function abs(a:Number):Number {
			return a > 0 ? a : 0 - a;
		}
		
		public static function confine(value:Number, min:Number, max:Number):Number { 
			return value < min ? min : (value > max ? max : value);
		}
		
		/**
		 * Returns a random int number within a given range
		 * @param	min
		 * @param	max
		 * @return
		 */
		public static function random(min:Number, max:Number):Number {
			return Math..random() * (max - min + 1) + min;
		}
		
		/**
		 * 向下取整
		 * @param	val
		 * @return
		 */
		public static function floor(val:Number):int {
			return int(val);
		}
		
		/**
		 * 四舍五入
		 * @param	val
		 * @return
		 */
		public static function round(val:Number):int {
			return val + .5;
		}
		
		/**
		 * 向上取整
		 * @param	val
		 * @return
		 */
		public static function ceil(val:Number):int {
			return (val << 0) == val ? val : (val + 1) << 0;
		}
		
		/**
		 * 根据两点确定这两点连线的二元一次方程 y = ax + b或者 x = ay + b
		 * @param ponit1
		 * @param point2
		 * @param type		指定返回函数的形式。为0则根据x值得到y，不为0则根据y得到x
		 * 
		 * @return 由参数中两点确定的直线的二元一次函数
		 */		
		public static function getLineFunc(ponit1:Point, point2:Point, type:int = 0):Function { 
			var resultFuc:Function;
			// 先考虑两点在一条垂直于坐标轴直线的情况，此时直线方程为 y = a 或者 x = a 的形式
			if (ponit1.x == point2.x) { 
				if (type) { 
					resultFuc =	function(y:Number):Number { return ponit1.x; };
				}else {
					throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
				}
				return resultFuc;
			}else if(ponit1.y == point2.y) {
				if (type) {
					throw new Error("两点所确定直线垂直于y轴，不能根据x值得到y值");
				}else {
					resultFuc =	function(x:Number):Number { return ponit1.y; };
				}
				return resultFuc;
			}
			
			// 当两点确定直线不垂直于坐标轴时直线方程设为 y = ax + b
			var a:Number;
			// 根据
			// y1 = ax1 + b
			// y2 = ax2 + b
			// 上下两式相减消去b, 得到 a = ( y1 - y2 ) / ( x1 - x2 ) 
			a = (ponit1.y - point2.y) / (ponit1.x - point2.x);
			
			var b:Number;
			//将a的值代入任一方程式即可得到b
			b = ponit1.y - a * ponit1.x;
			//把a,b值代入即可得到结果函数
			resultFuc =	type ? function(y:Number):Number { return (y - b) / a; } : function(x:Number):Number { return a * x + b; };
			return resultFuc;
		}
		
		/**
		 * 得到两点间连线的斜率 
		 * @param ponit1	
		 * @param point2
		 * @return 			两点间连线的斜率 
		 * 
		 */		
		public static function getSlope(ponit1:Point, point2:Point):Number { 
			return (point2.y - ponit1.y) / (point2.x - ponit1.x);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}