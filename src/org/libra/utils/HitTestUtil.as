package org.libra.utils {
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class HitTestUtil
	 * @author 式神
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
		public static function hitTrianglePoint(p1:Point, p2:Point, p3:Psoint):int { 
			return (p2.x - p1.x) * (p2.y + p1.y) + (p3.x - p2.x) * (p3.y + p2.y) + (p1.x - p3.x) * (p1.y + p3.y) ? 1 : 0;
		}
		 
		/**
		 * 顶点碰撞检测
		 * p1,p2,p3 为范围点
		 * p4为碰撞点。
		 * @return
		 */
		public static function hitPoint(p1:Point, p2:Point, p3:Point, p4:Point):Boolean { 
			var a:int = hitTrianglePoint(p1, p2, p3);
			var b:int = hitTrianglePoint(p4, p2, p3);
			var c:int = hitTrianglePoint(p1, p2, p4);
			var d:int = hitTrianglePoint(p1, p4, p3);
			return (b == a) && (c == a) && (d == a) ? true : false;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}