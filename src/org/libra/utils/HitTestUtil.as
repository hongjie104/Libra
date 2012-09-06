package org.libra.utils {
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class HitTestUtil
	 */
	public final class HitTestUtil {
		
		public function HitTestUtil() {
			throw new Error('HitTestUtil不能实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 面积检测
		 * @param   p1
		 * @param   p2
		 * @param   p3
		 * @return
		 */
		//public static function hitTrianglePoint(p1:Point, p2:Point, p3:Psoint):int { 
			//return (p2.x - p1.x) * (p2.y + p1.y) + (p3.x - p2.x) * (p3.y + p2.y) + (p1.x - p3.x) * (p1.y + p3.y) ? 1 : 0;
		//}
		 
		/**
		 * 顶点碰撞检测
		 * p1,p2,p3 为范围点
		 * p4为碰撞点。
		 * @return
		 */
		//public static function hitPoint(p1:Point, p2:Point, p3:Point, p4:Point):Boolean { 
			//var a:int = hitTrianglePoint(p1, p2, p3);
			//var b:int = hitTrianglePoint(p4, p2, p3);
			//var c:int = hitTrianglePoint(p1, p2, p4);
			//var d:int = hitTrianglePoint(p1, p4, p3);
			//return (b == a) && (c == a) && (d == a) ? true : false;
		//}
		
		public static function pointHitTriangle(px:int, py:int, x1:int, y1:int, x2:int, y2:int, x3:int, y3:int):Boolean {
			if ((px < x1 && px < x2 && px < x3) || 
				(px > x1 && px > x2 && px > x3) ||
				(py < y1 && py < y2 && py < y3) ||
				(py > y1 && py > y2 && py > y3)
				) { 
					return false;
				}
			var a1:int, a2:int, a3:int;
			//象限法：
			//a1 = quadrantJudging(px, py, x1, y1, x2, y2);
			//a2 = quadrantJudging(px, py, x2, y2, x3, y3);
			//a3 = quadrantJudging(px, py, x3, y3, x1, y1);
			
			//向量法：
			a1 = crossJudging(px, py, x1, y1, x2, y2);
			a2 = crossJudging(px, py, x2, y2, x3, y3);
			a3 = crossJudging(px, py, x3, y3, x1, y1);
			
			return (a1 > 0 && a2 > 0 && a3 > 0) || (a1 < 0 && a2 < 0 && a3 < 0);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private static function quadrantJudging(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int):int {
			return (x1 - x2) * (y3 - y2) - (y1 - y2) * (x3 - x2);
		}
		
		private static function crossJudging(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int):int {
			return (x1 -x2) * (y1 - y3) - (y1 - y2) * (x1 - x3);
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}