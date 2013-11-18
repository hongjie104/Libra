package org.libra.aStar.newAStar {
	import flash.geom.Point;
	import org.libra.utils.MathUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Grid
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 10/17/2013
	 * @version 1.0
	 * @see
	 */
	public final class Grid {
		
		private var _startNode:Node;
		private var _endNode:Node;
		private var _nodes:Vector.<Vector.<Node>>;
		private var _numCols:int;
		private var _numRows:int;

		private var type:int;

		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		
		public function Grid(numCols:int, numRows:int) {
			_numCols = numCols;
			_numRows = numRows;
			_nodes = new Vector.<Vector.<Node>>();

			for (var i:int = 0; i < _numCols; i++){
				_nodes[i] = new Vector.<Node>();
				for (var j:int = 0; j < _numRows; j++){
					_nodes[i][j] = new Node(i, j);
				}
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 *
		 * @param	type	0八方向 1四方向 2跳棋
		 */
		public function calculateLinks(type:int = 0):void {
			this.type = type;
			for (var i:int = 0; i < _numCols; i++){
				for (var j:int = 0; j < _numRows; j++){
					initNodeLink(_nodes[i][j], type);
				}
			}
		}

		public function getType():int {
			return type;
		}
		
		public function getNode(x:int, y:int):Node {
			if (x < 0) return null;
			if (x >= _nodes.length) return null;
			if (y < 0) return null;
			if (y >= _nodes[x].length) return null;
			return _nodes[x][y];
		}

		public function setEndNode(x:int, y:int):void {
			if (x < 0) return;
			if (x >= _nodes.length) return;
			if (y < 0) return;
			if (y >= _nodes[x].length) return;
			_endNode = _nodes[x][y];
		}

		public function setStartNode(x:int, y:int):void {
			_startNode = _nodes[x][y];
		}

		public function setWalkable(x:int, y:int, value:Boolean):void {
			_nodes[x][y].walkable = value;
		}

		public function get endNode():Node {
			return _endNode;
		}

		public function get numCols():int {
			return _numCols;
		}

		public function get numRows():int {
			return _numRows;
		}

		public function get startNode():Node {
			return _startNode;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 *
		 * @param	node
		 * @param	type	0八方向 1四方向 2跳棋
		 */
		private function initNodeLink(node:Node, type:int):void {
			var startX:int = Math.max(0, node.x - 1);
			var endX:int = Math.min(numCols - 1, node.x + 1);
			var startY:int = Math.max(0, node.y - 1);
			var endY:int = Math.min(numRows - 1, node.y + 1);
			node.links = new Vector.<Link>();
			for (var i:int = startX; i <= endX; i++){
				for (var j:int = startY; j <= endY; j++){
					var test:Node = getNode(i, j);
					if (test == node || !test.walkable){
						continue;
					}
					if (type != 2 && i != node.x && j != node.y){
						var test2:Node = getNode(node.x, j);
						if (!test2.walkable){
							continue;
						}
						test2 = getNode(i, node.y);
						if (!test2.walkable){
							continue;
						}
					}
					var cost:Number = _straightCost;
					if (!((node.x == test.x) || (node.y == test.y))){
						if (type == 1){
							continue;
						}
						if (type == 2 && (node.x - test.x) * (node.y - test.y) == 1){
							continue;
						}
						if (type == 2){
							cost = _straightCost;
						} else {
							cost = _diagCost;
						}
					}
					node.links.push(new Link(test, cost));
				}
			}
		}
		
		/**
		 * 判断两节点之间是否存在障碍物
		 * @param point1
		 * @param point2
		 * @return
		 *
		 */
		internal function hasBarrier(startX:int, startY:int, endX:int, endY:int):Boolean {
			//如果起点终点是同一个点那傻子都知道它们间是没有障碍物的
			if (startX == endX && startY == endY)
				return false;
			if (getNode(endX, endY).walkable == false)
				return true;
			
			//两节点中心位置
			var point1:Point = new Point(startX + 0.5, startY + 0.5);
			var point2:Point = new Point(endX + 0.5, endY + 0.5);
			
			var distX:Number = MathUtil.abs(endX - startX);
			var distY:Number = MathUtil.abs(endY - startY);
			
			/**遍历方向，为true则为横向遍历，否则为纵向遍历*/
			var loopDirection:Boolean = distX > distY;
			
			/**起始点与终点的连线方程*/
			var lineFuction:Function;
			
			/** 循环递增量 */
			var i:Number;
			
			/** 循环起始值 */
			var loopStart:Number;
			
			/** 循环终结值 */
			var loopEnd:Number;
			
			/** 起终点连线所经过的节点 */
			var nodesPassed:Vector.<Node>;
			var elem:Node;
			
			//为了运算方便，以下运算全部假设格子尺寸为1，格子坐标就等于它们的行、列号
			if (loopDirection) {
				lineFuction = MathUtil.getLineFunc(point1, point2, 0);
				
				loopStart = MathUtil.min(startX, endX);
				loopEnd = MathUtil.max(startX, endX);
				
				//开始横向遍历起点与终点间的节点看是否存在障碍(不可移动点) 
				for (i = loopStart; i <= loopEnd; i++) {
					//由于线段方程是根据终起点中心点连线算出的，所以对于起始点来说需要根据其中心点
					//位置来算，而对于其他点则根据左上角来算
					if (i == loopStart)
						i += .5;
					//根据x得到直线上的y值
					var yPos:Number = lineFuction(i);
					
					nodesPassed = getNodesUnderPoint(i, yPos);
					for each (elem in nodesPassed) {
						if (elem.walkable == false)
							return true;
					}
					
					if (i == loopStart + .5)
						i -= .5;
				}
			} else {
				lineFuction = MathUtil.getLineFunc(point1, point2, 1);
				
				loopStart = MathUtil.min(startY, endY);
				loopEnd = MathUtil.max(startY, endY);
				
				//开始纵向遍历起点与终点间的节点看是否存在障碍(不可移动点)
				for (i = loopStart; i <= loopEnd; i++) {
					if (i == loopStart)
						i += .5;
					//根据y得到直线上的x值
					var xPos:Number = lineFuction(i);
					
					nodesPassed = getNodesUnderPoint(xPos, i);
					for each (elem in nodesPassed) {
						if (elem.walkable == false)
							return true;
					}
					
					if (i == loopStart + .5)
						i -= .5;
				}
			}
			
			return false;
		}
		
		/**
		 * 得到一个点下的所有节点
		 * @param xPos		点的横向位置
		 * @param yPos		点的纵向位置
		 * @param grid		所在网格
		 * @param exception	例外格，若其值不为空，则在得到一个点下的所有节点后会排除这些例外格
		 * @return 			共享此点的所有节点
		 *
		 */
		internal function getNodesUnderPoint(xPos:Number, yPos:Number, exception:Array = null):Vector.<Node> {
			var result:Vector.<Node> = new Vector.<Node>();
			var xIsInt:Boolean = xPos % 1 == 0;
			var yIsInt:Boolean = yPos % 1 == 0;
			
			//点由四节点共享情况
			if (xIsInt && yIsInt) {
				result[0] = getNode(xPos - 1, yPos - 1);
				result[1] = getNode(xPos, yPos - 1);
				result[2] = getNode(xPos - 1, yPos);
				result[3] = getNode(xPos, yPos);
			} 
			//点由2节点共享情况
			//点落在两节点左右临边上
			else if (xIsInt && !yIsInt) {
				result[0] = getNode(xPos - 1, int(yPos));
				result[1] = getNode(xPos, int(yPos));
			} 
			//点落在两节点上下临边上
			else if (!xIsInt && yIsInt) {
				result[0] = getNode(int(xPos), yPos - 1);
				result[1] = getNode(int(xPos), yPos);
			} 
			//点由一节点独享情况
			else {
				result[0] = getNode(int(xPos), int(yPos));
			}
			
			//在返回结果前检查结果中是否包含例外点，若包含则排除掉
			if (exception && exception.length > 0) {
				for (var i:int = 0; i < result.length; i++) {
					if (exception.indexOf(result[i]) != -1) {
						result.splice(i, 1);
						i--;
					}
				}
			}
			
			return result;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}