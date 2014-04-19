package org.libra.utils.sort {
	import org.libra.displayObject.interfaces.ISprite45;
	import starling.display.DisplayObject;
	
	public final class Sort45 {
		
		private static var _instance:Sort45;
		
		private var _itemList:Vector.<ISprite45>;
		
		private var _movingItemList:Vector.<ISprite45>;
		
		/**
		 * 帧数的间隔，没有必要每一帧都排一次序
		 * 10帧一排，也是可以的
		 * @private
		 */
		private var _interval:int = 10;
		
		/**
		 * 当前帧数，每帧自加1，当等于_interval时，排一次序，然后_curFrame设为0
		 * @private
		 */
		private var _curFrame:int;
		
		public function Sort45(s:Singleton) {
			//throw new Error('Sort45类无法实例化');
			_itemList = new Vector.<ISprite45>();
			_movingItemList = new Vector.<ISprite45>();
		}
		
		/**
		 * 获取物品在队列中的唯一深度
		 * 原理很简单，默认物品在最上层，然后遍历之前已经排好序的队列，直到找到在深度目标物品深度以下的，break
		 * 即可获得目标物品的正确深度了
		 * @param target 目标物品
		 * @param itemList 已经排好序的物品队列
		 * @return  目标物品在队列中的深度
		 */
		public static function getDepth(target:ISprite45, itemList:Vector.<ISprite45>):int {
			var l:int = itemList.length;
			var index:int = l;
			var item:ISprite45;
			while (--l > -1) {
				item = itemList[l];
				if ((item.bottomX <= target.topX && item.topY <= target.bottomY) || (item.bottomY < target.topY)) {
					break;
				} else {
					index--;
				}
			}
			return index;
		}
		
		/**
		 * 每帧排序
		 */
		public function sortPerFrame():void {
			if (++_curFrame < _interval) {
				return;
			}
			_curFrame = 0
			var list:Vector.<ISprite45> = _itemList.slice(0);
			var l:int = 0;
			var counter:int = 0;
			var added:Boolean = false;
			for (var i:* in _movingItemList) {
				added = false;
				l = list.length;
				if (l == 0) {
					list[0] = _movingItemList[i];
				}else {
					counter = 0;
					while (counter < l) {
						if (isJustBack(_movingItemList[i], list[counter], true)) { 
							list.splice(counter, 0, _movingItemList[i]);
							added = true;
							break;
						}
						counter += 1;
					}
					if (!added) {
						list[list.length] = _movingItemList[i];
					}
				}
			}
			l = list.length;
			counter = 0;
			var d:DisplayObject;
			while (counter < l) {
				d = list[counter] as DisplayObject;
				if (d.parent) {
					d.parent.setChildIndex(d, counter);
				}
				counter += 1;
			}
		}
		
		public function removeItem(item:ISprite45):void { 
			var index:int = _movingItemList.indexOf(item);
			if (index != -1) {
				_movingItemList.splice(index, 1);
			}else {
				index = _itemList.indexOf(item);
				if (index != -1) {
					_itemList.splice(index, 1);
				}
			}
		}
		
		public function clearItem():void {
			this._movingItemList.length = 0;
			this._itemList.length = 0;
		}
		
		public function addItem(item:ISprite45, moving:Boolean):void {
			if (moving) {
				_movingItemList[_movingItemList.length] = item;
			}else {
				const index:int = getDepth(item, this._itemList);
				_itemList.splice(index, 0, item);
			}
		}
		
		public static function get instance():Sort45 {
			return _instance ||= new Sort45(new Singleton());
		}
		
		/**
		 * 判定两个物体的前后关系
		 * @param	item 未判定物体
		 * @param	target 参考物
		 * @param	isMoving 未判定物体是否会动
		 * 如果会动，那么就先根据两者的Toppoint来判定先后，如果TopPoint相等，那么item在target之上
		 * 否则按常规来判断
		 * @return
		 */
		private function isJustBack(item:ISprite45, target:ISprite45, isMoving:Boolean = false):Boolean { 
			if (isMoving) {
				if (item.topX == target.topX) {
					if (item.topY == target.topY) {
						return true;
					}
				}
			}
			return (item.bottomX <= target.topX && item.topY <= target.bottomY) || (item.bottomY < target.topY);
		}
	}
}

final class Singleton { }