package org.libra.aStar.newAStar {
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Node
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 10/17/2013
	 * @version 1.0
	 * @see
	 */
	public final class Node {
		
		public var x:int;
		
		public var y:int;
		
		public var f:Number;
		
		public var g:Number;
		
		public var h:Number;
		
		public var walkable:Boolean = true;
		
		public var parent:Node;
		
		public var version:int = 1;
		
		public var links:Vector.<Link>;

		public function Node(x:int, y:int){
			this.x = x;
			this.y = y;
		}
			
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}