package org.libra.aStar {
	import flash.utils.getTimer;
	import org.libra.log4a.Logger;
	import org.libra.utils.MathUtil;
	
	public class AStar {
		
		/**
		 * 八方向
		 */
		public static const EIGHT:int = 8;
		
		/**
		 * 四方向
		 */
		public static const FOUR:int = 4;
		
		private static var instance:AStar;
		
		private var _open:Binary;
		private var _closed:Vector.<Node>;
		private var _grid:Grid;
		private var _endNode:Node;
		private var _startNode:Node;
		private var _path:Array;
		private var _heuristic:Function = diagonal;
		private var _straightCost:Number = 1.0;
		private var _diagCost:Number = Math.SQRT2;
		
		private var _floydPath:Array;
		
		/**
		 * 多少方向寻路，默认是八方向
		 */
		private var dir:int;
		
		public function AStar(singleton:Singleton) {
			_grid = new Grid();
			_open = new Binary("f");
			_closed = new Vector.<Node>();
			dir = EIGHT;
		}
		
		/**
		 * 设为几方向寻路。
		 * @param	val 4或者8，如果不为4，那么就是8
		 */
		public function setDir(val:int):void {
			this.dir = val;
		}
		
		public function findPath():Boolean {
			_closed.length = 0;
			this._open.reset();
			
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			
			return search();
		}
		
		private function search():Boolean {
			//异步运算。当上一次遍历超出最大允许值后停止遍历，下一次从
			//上次暂停处开始继续遍历		
			var node:Node = _startNode;
			var min:Function = MathUtil.min;
			var max:Function = MathUtil.max;
			while (node != _endNode) {
				var startX:int = max(0, node.x - 1);
				var endX:int = min(_grid.numCols - 1, node.x + 1);
				var startY:int = max(0, node.y - 1);
				var endY:int = min(_grid.numRows - 1, node.y + 1);
				
				for (var i:int = startX; i <= endX; i++) {
					for (var j:int = startY; j <= endY; j++) {
						var test:Node = _grid.getNode(i, j);
						if (test == node) continue;
						if (!test.walkable) continue;
						//if (!isDiagonalWalkable(node, test)) continue;
						if (!node.walkable) continue;
						
						var cost:Number;
						if ((node.x == test.x) || (node.y == test.y)) {
							cost = _straightCost;
						}else {
							cost = _diagCost;
							//如果是四方向寻路，那么continue
							if (dir == FOUR) {
								continue;	
							}
						}
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						var isInOpen:Boolean = _open.indexOf(test) != -1;
						if (isInOpen || _closed.indexOf(test) != -1) {
							if (test.f > f) {
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
								if (isInOpen)
									_open.updateNode(test);
							}
						} else {
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push(test);
						}
					}
				}
				_closed[_closed.length] = node;
				if (!_open.length) {
					Logger.warn('AStar找不到路');
					return false
				}
				node = _open.shift() as Node;
			}
			buildPath();
			return true;
		}
		
		public function setSize(cols:int, rows:int):void { 
			this._grid.setSize(cols, rows);
		}
		
		/** 弗洛伊德路径平滑处理
		 form http://wonderfl.net/c/aWCe*/
		public function floyd():void {
			if (!path) return;
			_floydPath = _path.concat();
			if (dir == EIGHT) return;
			var len:int = _floydPath.length;
			if (len > 2) {
				var vector:Node = new Node(0, 0);
				var tempVector:Node = new Node(0, 0);
				//遍历路径数组中全部路径节点，合并在同一直线上的路径节点
				//假设有1,2,3,三点，若2与1的横、纵坐标差值分别与3与2的横、纵坐标差值相等则
				//判断此三点共线，此时可以删除中间点2
				floydVector(vector, _floydPath[len - 1], _floydPath[len - 2]);
				for (var i:int = _floydPath.length - 3; i >= 0; i--) {
					floydVector(tempVector, _floydPath[i + 1], _floydPath[i]);
					if (vector.x == tempVector.x && vector.y == tempVector.y) {
						_floydPath.splice(i + 1, 1);
					} else {
						vector.x = tempVector.x;
						vector.y = tempVector.y;
					}
				}
			}
			//合并共线节点后进行第二步，消除拐点操作。算法流程如下：
			//如果一个路径由1-10十个节点组成，那么由节点10从1开始检查
			//节点间是否存在障碍物，若它们之间不存在障碍物，则直接合并
			//此两路径节点间所有节点。
			len = _floydPath.length;
			for (i = len - 1; i >= 0; i--) {
				for (var j:int = 0; j <= i - 2; j++) {
					if (_grid.hasBarrier(_floydPath[i].x, _floydPath[i].y, _floydPath[j].x, _floydPath[j].y) == false) {
						for (var k:int = i - 1; k > j; k--) {
							_floydPath.splice(k, 1);
						}
						i = j;
						len = _floydPath.length;
						break;
					}
				}
			}
		}
		
		private function buildPath():void {
			_path = [];
			var node:Node = _endNode;
			_path.push(node);
			while (node != _startNode) {
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		private function floydVector(target:Node, n1:Node, n2:Node):void {
			target.x = n1.x - n2.x;
			target.y = n1.y - n2.y;
		}
		
		/** 判断两个节点的对角线路线是否可走 */
		private function isDiagonalWalkable(node1:Node, node2:Node):Boolean {
			return _grid.getNode(node1.x, node2.y).walkable && _grid.getNode(node2.x, node1.y).walkable;
		}
		
		//private function manhattan(node:Node):Number {
			//return MathUtil.abs(node.x - _endNode.x) * _straightCost + MathUtil.abs(node.y + _endNode.y) * _straightCost;
		//}
		//
		//private function euclidian(node:Node):Number {
			//var dx:Number = node.x - _endNode.x;
			//var dy:Number = node.y - _endNode.y;
			//return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		//}
		
		private function diagonal(node:Node):Number {
			var dx:Number = node.x - _endNode.x < 0 ? _endNode.x - node.x : node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y < 0 ? _endNode.y - node.y : node.y - _endNode.y;
			var diag:Number = dx < dy ? dx : dy;
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		public static function getInstance():AStar {
			return instance ||= new AStar(new Singleton());
		}
		
		public function getGrid():Grid {
			return this._grid;
		}
		
		//---------------------------------------get/set functions-----------------------------//
		
		public function get path():Array {
			return _path;
		}
		
		public function get floydPath():Array {
			return _floydPath;
		}
	
	}
}
final class Singleton { }