package org.libra.aStar.newAStar {
	import org.libra.utils.MathUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class AStar
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 10/17/2013
	 * @version 1.0
	 * @see
	 */
	public final class AStar {
		
		private var _open:BinaryHeap;
		
		private var _grid:Grid;
		
		private var _endNode:Node;
		
		private var _startNode:Node;
		
		private var _path:Vector.<Node>;
		
		public var heuristic:Function;
		
		private var _straightCost:Number = 1.0;
		
		private var _diagCost:Number = Math.SQRT2;
		
		private var _nowVersion:int = 1;
		
		private static var _instance:AStar;
		
		public function AStar(grid:Grid) {
			this._grid = grid;
			_path = new Vector.<Node>();
			//heuristic = euclidian2;
			heuristic = manhattan;
			instance = this;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/

		public function findPath():Boolean {
			_endNode = _grid.endNode;
			_nowVersion++;
			_startNode = _grid.startNode;
			_open = new BinaryHeap(justMin);
			_startNode.g = 0;
			return search();
		}

		public function search():Boolean {
			var node:Node = _startNode;
			node.version = _nowVersion;
			var i:int = 0;
			var cost:Number = .0;
			var g:Number = .0;
			var h:Number = .0;
			var f:Number = .0;
			var test:Node;
			while (node != _endNode){
				var len:int = node.links.length;
				for (i = 0; i < len; i++){
					test = node.links[i].node;
					cost = node.links[i].cost;
					g = node.g + cost;
					h = heuristic(test);
					f = g + h;
					if (test.version == _nowVersion){
						if (test.f > f){
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
						}
					} else {
						test.f = f;
						test.g = g;
						test.h = h;
						test.parent = node;
						_open.ins(test);
						test.version = _nowVersion;
					}
				}
				if (_open.a.length == 1){
					return false;
				}
				node = _open.pop();
			}
			buildPath();
			return true;
		}
		
		public function get path():Vector.<Node> {
			return _path;
		}
		
		public function get grid():Grid {
			return _grid;
		}
		
		public function get floydPath():Vector.<Node> {
			return _floydPath;
		}
		
		public function manhattan(node:Node):Number {
			return Math.abs(node.x - _endNode.x) + Math.abs(node.y - _endNode.y);
		}

		public function manhattan2(node:Node):Number {
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			return dx + dy + Math.abs(dx - dy) / 1000;
		}

		public function euclidian(node:Node):Number {
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy);
		}

		private var TwoOneTwoZero:Number = 2 * Math.cos(Math.PI / 3);
		
		private var _floydPath:Vector.<Node>;

		public function chineseCheckersEuclidian2(node:Node):Number {
			var y:int = node.y / TwoOneTwoZero;
			var x:int = node.x + node.y / 2;
			var dx:Number = x - _endNode.x - _endNode.y / 2;
			var dy:Number = y - _endNode.y / TwoOneTwoZero;
			return sqrt(dx * dx + dy * dy);
		}

		public function euclidian2(node:Node):Number {
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return dx * dx + dy * dy;
		}
		
		public function diagonal(node:Node):Number {
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		/** 弗洛伊德路径平滑处理
		 form http://wonderfl.net/c/aWCe*/
		public function floyd():void {
			if (!_path) return;
			_floydPath = _path.concat();
			//八方向寻路，直接return
			if (_grid.getType() == 1) return;
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
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function floydVector(target:Node, n1:Node, n2:Node):void {
			target.x = n1.x - n2.x;
			target.y = n1.y - n2.y;
		}
		
		private function justMin(x:Object, y:Object):Boolean {
			return x.f < y.f;
		}

		private function buildPath():void {
			_path.length = 0;
			var node:Node = _endNode;
			_path.push(node);
			while (node != _startNode){
				node = node.parent;
				_path.unshift(node);
			}
		}

		private function sqrt(x:Number):Number {
			return Math.sqrt(x);
		}
		
		static public function get instance():AStar {
			return instance;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}