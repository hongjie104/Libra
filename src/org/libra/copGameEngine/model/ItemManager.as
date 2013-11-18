package org.libra.copGameEngine.model {
	import org.libra.copGameEngine.model.element.JItem;
	import org.libra.copGameEngine.model.element.JUserInfo;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ItemManager
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class ItemManager extends Actor {
		
		protected var _itemList:Vector.<JItem>;
		
		public function ItemManager() {
			super();
			_itemList = JUserInfo.instance.itemList;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function createItem():JItem {
			return new JItem();
		}
		
		public function addItem(val:JItem):JItem {
			if (getItemIndex(val) == -1) {
				this._itemList[_itemList.length] = val;
				return val;
			}
			return null;
		}
		
		public function removeItem(val:JItem):JItem {
			const index:int = getItemIndex(val);
			if (index == -1) return null;
			return _itemList.splice(index, 1)[0];
		}
		
		public function getItemCount(type:int):int {
			var count:int = 0;
			var i:int = _itemList.length;
			while (--i > -1) {
				if (_itemList[i].type == type) {
					count += _itemList[i].count;
				}
			}
			return count;
		}
		
		public function getItem(id:String):JItem {
			var i:int = _itemList.length;
			while (--i > -1) {
				if (_itemList[i].id == id) {
					return _itemList[i];
				}
			}
			return null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function getItemIndex(val:JItem):int {
			var i:int = this._itemList.length;
			while (--i > -1) {
				if (_itemList[i] == val) return i;
			}
			return -1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}