package org.libra.aStar {
	
	/**
	 * 二叉堆数据结构
	 * @author S_eVent
	 */
	public class Binary {
		
		private var _data:Array;
		private var _compareValue:String;
		
		/**
		 * @param compareValue	排序字段，若为空字符串则直接比较被添加元素本身的值
		 */
		public function Binary(compareValue:String = "") {
			_data = [];
			_compareValue = compareValue;
		}
		
		/** 向二叉堆中添加元素
		 * @param node			欲添加的元素对象
		 */
		public function push(node:Object):void {
			//将新节点添至末尾先
			var len:int = _data.length;
			_data[len++] = node;
			
			//若数组中只有一个元素则省略排序过程，否则对新元素执行上浮过程
			if (len > 1) {
				/** 新添入节点当前所在索引 */
				var index:int = len;
				
				/** 新节点当前父节点所在索引 */
				var parentIndex:int = index / 2 - 1;
				
				var temp:Object;
				
				//和它的父节点（位置为当前位置除以2取整，比如第4个元素的父节点位置是2，第7个元素的父节点位置是3）比较，
				//如果新元素比父节点元素小则交换这两个元素，然后再和新位置的父节点比较，直到它的父节点不再比它大，
				//或者已经到达顶端，及第1的位置
				
				while (compareTwoNodes(node, _data[parentIndex])) {
					temp = _data[parentIndex];
					_data[parentIndex] = node;
					_data[index - 1] = temp;
					index /= 2;
					parentIndex = index / 2 - 1;
				}
			}
		}
		
		/** 弹出开启列表中第一个元素 */
		public function shift():Object {
			//先弹出列首元素
			var result:Object = _data.shift();
			
			/** 数组长度 */
			var len:int = _data.length;
			
			//若弹出列首元素后数组空了或者其中只有一个元素了则省略排序过程，否则对列尾元素执行下沉过程
			if (len > 1) {
				/** 列尾节点 */
				var lastNode:Object = _data.pop();
				
				//将列尾元素排至首位
				_data.unshift(lastNode);
				
				/** 末尾节点当前所在索引 */
				var index:int = 0;
				
				/** 末尾节点当前第一子节点所在索引 */
				var childIndex:int = (index + 1) * 2 - 1;
				
				/** 末尾节点当前两个子节点中较小的一个的索引 */
				var comparedIndex:int;
				
				var temp:Object;
				
				//和它的两个子节点比较，如果较小的子节点比它小就将它们交换，直到两个子节点都比它大
				while (childIndex < len) {
					//只有一个子节点的情况
					if (childIndex + 1 == len) {
						comparedIndex = childIndex;
					} 
					//有两个子节点则取其中较小的那个
					else {
						comparedIndex = compareTwoNodes(_data[childIndex], _data[childIndex + 1]) ? childIndex : childIndex + 1;
					}
					
					if (compareTwoNodes(_data[comparedIndex], lastNode)) {
						temp = _data[comparedIndex];
						_data[comparedIndex] = lastNode;
						_data[index] = temp;
						index = comparedIndex;
						childIndex = (index + 1) * 2 - 1;
					} else {
						break;
					}
				}
			}
			return result;
		}
		
		/** 更新某一个节点的值。在你改变了二叉堆中某一节点的值以后二叉堆不会自动进行排序，所以你需要手动
		 *  调用此方法进行二叉树更新 */
		public function updateNode(node:Object):void {
			var index:int = _data.indexOf(node) + 1;
			if (index == 0) {
				throw new Error("无法更新一个二叉堆中不存在的节点!");
			} else {
				var parentIndex:int = index / 2 - 1;
				var temp:Object;
				//上浮过程开始喽
				while (compareTwoNodes(node, _data[parentIndex])) {
					temp = _data[parentIndex];
					_data[parentIndex] = node;
					_data[index - 1] = temp;
					index /= 2;
					parentIndex = index / 2 - 1;
				}
			}
		}
		
		/** 查找某节点所在索引位置 */
		public function indexOf(node:Object):int {
			return _data.indexOf(node);
		}
		
		public function get length():uint {
			return _data.length;
		}
		
		public function reset():void {
			_data.length = 0;
		}
		
		/**比较两个节点，返回true则表示第一个节点小于第二个*/
		private function compareTwoNodes(node1:Object, node2:Object):Boolean {
			return _compareValue ? node1[_compareValue] < node2[_compareValue] : node1 < node2;
		}
		
		/** 写此方法的目的在于快速trace出所需要查看的结果，直接trace一个Binary对象即可得到其中全部元素的值或
		 * 排序字段的值 */
		public function toString():String {
			var result:String = "";
			if (_compareValue) {
				var len:int = _data.length;
				for (var i:int = 0; i < len; i++) {
					result += _data[i][_compareValue];
					if (i < len - 1)
						result += ",";
				}
			} else {
				result = _data.toString();
			}
			return result;
		}
	}
}