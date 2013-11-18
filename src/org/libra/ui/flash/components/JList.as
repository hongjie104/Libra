package org.libra.ui.flash.components {
	import flash.events.Event;
	import flash.events.MouseEvent;
	import org.libra.ui.Constants;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.ui.invalidation.InvalidationFlag;
	import org.libra.utils.displayObject.DepthUtil;
	import org.libra.utils.MathUtil;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JList
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-03-2012
	 * @version 1.0
	 * @see
	 */
	public class JList extends Component {
		
		private var _itemList:Vector.<JListItem>;
		
		/**
		 * 数据源
		 */
		private var _dataList:Vector.<Object>;
		
		private var _scrollBar:JScrollBar;
		
		private var _itemHeight:int;
		
		private var _selectedIndex:int;
		
		public function JList(x:int = 0, y:int = 0, itemHeight:int = 20, dataList:Vector.<Object> = null) { 
			super(x, y);
			this._itemHeight = itemHeight;
			this._dataList = dataList ? dataList : new Vector.<Object>();
			_itemList = new Vector.<JListItem>();
			this.setSize(100, 300);
			_selectedIndex = -1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addItem(item:Object):void {
			this._dataList[_dataList.length] = item;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function addItemAt(item:Object, index:int):void{
			index = MathUtil.max(0, index);
			index = MathUtil.min(_dataList.length, index);
			_dataList.splice(index, 0, item);
			invalidate(InvalidationFlag.DATA);
		}
		
		public function removeItem(item:Object):void{
			var index:int = _dataList.indexOf(item);
			removeItemAt(index);
		}
		
		public function removeItemAt(index:int):void {
			if(index < 0 || index >= _itemList.length) return;
			_dataList.splice(index, 1);
			invalidate(InvalidationFlag.DATA);
		}
		
		public function clear():void {
			_dataList.length = 0;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function set selectedIndex(value:int):void {
			this._selectedIndex = value >= 0 && value < _itemList.length ? value : -1;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedItem(item:JListItem):void {
			this.selectedIndex = this._itemList.indexOf(item);
		}
		
		public function get selectedItem():JListItem {
			return _selectedIndex >= 0 && _selectedIndex < _itemList.length ? _itemList[_selectedIndex] : null;
		}
		
		//public function setItemHeight(value:int):void { 
			//_itemHeight = value;
			//initListItems();
			//invalidate();
		//}
		//
		//public function getItemHeight():int {
			//return _itemHeight;
		//}
		
		public function set dataList(value:Vector.<Object>):void {
			this._dataList = value;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get dataList():Vector.<Object> {
			return _dataList;
		}
		
		public function set autoHideScrollBar(value:Boolean):void {
			_scrollBar.autoHide = value ;
		}
		
		override public function clone():Component {
			return new JList(x, y, _itemHeight, _dataList);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function init():void {
			super.init();
			
			_scrollBar = new JScrollBar(Constants.VERTICAL);
			this.addChild(_scrollBar);
		}
		
		override protected function refreshData():void {
			_scrollBar.thumbPercent = _actualHeight / (_dataList.length * _itemHeight); 
			const pageSize:Number = MathUtil.floor(_actualHeight / _itemHeight);
			_scrollBar.max = MathUtil.max(0, _dataList.length - pageSize);
			_scrollBar.pageSize = pageSize;
			_scrollBar.height = _actualHeight;
			scrollToSelection();
		}
		
		override protected function resize():void {
			_scrollBar.x = _actualWidth - _scrollBar.width;
			for each(var item:JListItem in _itemList) {
				this.removeChild(item);
			}
			var itemPool:Vector.<JListItem> = this._itemList.slice();
			_itemList.length = 0;
			const numItems:int = Math.ceil(_actualHeight / _itemHeight);
			for(var i:int = 0; i < numItems; i++) {
				item = itemPool.length ? itemPool.shift() : new JListItem();
				item.setLocation(0, i * _itemHeight);
				item.setSize(width, _itemHeight);
				this._itemList[i] = item;
				item.addEventListener(MouseEvent.CLICK, onSelect);
				this.addChild(item);
			}
			DepthUtil.bringToTop(_scrollBar);
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			_scrollBar.addEventListener(Event.CHANGE, onScrollBarScroll);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			var i:int = _itemList.length;
			while (--i > -1) 
				_itemList[i].addEventListener(MouseEvent.CLICK, onSelect);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			_scrollBar.removeEventListener(Event.CHANGE, onScrollBarScroll);
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			var i:int = _itemList.length;
			while (--i > -1) 
				_itemList[i].removeEventListener(MouseEvent.CLICK, onSelect);
		}
		
		protected function updateItems():void {
			const offset:int = this._scrollBar.value;
			const numItems:int = this._itemList.length;
			const numData:int = this._dataList.length;
			var item:JListItem;
			for(var i:int = 0; i < numItems; i++) {
				item = _itemList[i];
				item.setSize(_actualWidth, _itemHeight);
				item.data = offset + i < numData ? this._dataList[offset + i] : '';
				item.selected = offset + i == _selectedIndex;
			}
		}
		
		/**
		 * 如果选中的item不在视野中，挑战滚动条数值，直到选中的item出现
		 */
		protected function scrollToSelection():void {
			if(this._selectedIndex == -1) {
				this._scrollBar.value = 0;
			} else {
				const numItems:int = _itemList.length;
				if (_scrollBar.value + numItems < _selectedIndex) 
					_scrollBar.value = _selectedIndex - numItems + 1;
			}
			updateItems();
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onScrollBarScroll(e:Event):void {
			updateItems();
		}
		
		private function onMouseWheel(e:MouseEvent):void {
			this._scrollBar.changeValue(0 - e.delta);
			updateItems();
		}
		
		protected function onSelect(event:Event):void {
			if (!(event.target is JListItem)) return;
			
			var target:JListItem = event.target as JListItem;
			//var offset:int = _scrollBar.getValue();
			const l:int = _itemList.length;
			for(var i:int = 0; i < l; i++) {
				if (_itemList[i] == target) continue; //this._selectedIndex = i + offset;
				_itemList[i].selected = false;
			}
			target.selected = true;
			this.selectedItem = target;
			if (!UIManager.UI_EDITOR) event.stopPropagation();
		}
		
	}

}