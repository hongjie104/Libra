package org.libra.aStar {
	
	/**
	 * Represents a specific node evaluated as part of a pathfinding algorithm.
	 */
	public class Node {
		
		/** 节点列号 */
		internal var x:int;
		
		/** 节点行号 */
		internal var y:int;
		
		internal var f:Number;
		internal var g:Number;
		internal var h:Number;
		internal var walkable:Boolean = true;
		internal var parent:Node;
		internal var costMultiplier:Number = 1.0;
		
		/** 屏幕坐标系中的x坐标 */
		internal var posX:Number;
		/** 屏幕坐标系中的y坐标 */
		internal var posY:Number;
		
		/** 埋葬深度 */
		internal var buriedDepth:int = -1;
		
		/** 距离 */
		internal var distance:Number;
		
		public function Node(x:int, y:int) {
			this.x = x;
			this.y = y;
		}
		
		/**
		 * 判断两个节点屏幕位置是否一样
		 * @param otherNode
		 * @return
		 *
		 */
		internal function posEquals(otherNode:Node):Boolean {
			return posX == otherNode.posX && posY == otherNode.posY;
		}
		
		/** 得到此节点到另一节点的网格距离 */
		internal function getDistanceTo(targetNode:Node):Number {
			var disX:Number = targetNode.x - x;
			var disY:Number = targetNode.y - y;
			distance = Math.sqrt(disX * disX + disY * disY);
			return distance;
		}
		
		public function toString():String {
			return 'x = ' + x + ',y = ' + y;
		}
	}
}