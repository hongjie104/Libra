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
		
		private var $itemList:Vector.<JListItem>;
		
		/**
		 * 数据源
		 */
		private var $dataList:Vector.<Object>;
		
		private var $scrollBar:JScrollBar;
		
		private var $itemHeight:int;
		
		private var $selectedIndex:int;
		
		public function JList(x:int = 0, y:int = 0, itemHeight:int = 20, dataList:Vector.<Object> = null) { 
			super(x, y);
			this.$itemHeight = itemHeight;
			this.$dataList = dataList ? dataList : new Vector.<Object>();
			$itemList = new Vector.<JListItem>();
			this.setSize(100, 300);
			$selectedIndex = -1;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function addItem(item:Object):void {
			this.$dataList[$dataList.length] = item;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function addItemAt(item:Object, index:int):void{
			index = MathUtil.max(0, index);
			index = MathUtil.min($dataList.length, index);
			$dataList.splice(index, 0, item);
			invalidate(InvalidationFlag.DATA);
		}
		
		public function removeItem(item:Object):void{
			var index:int = $dataList.indexOf(item);
			removeItemAt(index);
		}
		
		public function removeItemAt(index:int):void {
			if(index < 0 || index >= $itemList.length) return;
			$dataList.splice(index, 1);
			invalidate(InvalidationFlag.DATA);
		}
		
		public function clear():void {
			$dataList.length = 0;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function set selectedIndex(value:int):void {
			this.$selectedIndex = value >= 0 && value < $itemList.length ? value : -1;
			dispatchEvent(new Event(Event.SELECT));
		}
		
		public function get selectedIndex():int {
			return $selectedIndex;
		}
		
		public function set selectedItem(item:JListItem):void {
			this.selectedIndex = this.$itemList.indexOf(item);
		}
		
		public function get selectedItem():JListItem {
			return $selectedIndex >= 0 && $selectedIndex < $itemList.length ? $itemList[$selectedIndex] : null;
		}
		
		//public function setItemHeight(value:int):void { 
			//$itemHeight = value;
			//initListItems();
			//invalidate();
		//}
		//
		//public function getItemHeight():int {
			//return $itemHeight;
		//}
		
		public function set dataList(value:Vector.<Object>):void {
			this.$dataList = value;
			invalidate(InvalidationFlag.DATA);
		}
		
		public function get dataList():Vector.<Object> {
			return $dataList;
		}
		
		public function set autoHideScrollBar(value:Boolean):void {
			$scrollBar.autoHide = value ;
		}
		
		override public function clone():Component {
			return new JList(x, y, $itemHeight, $dataList);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		override protected function init():void {
			super.init();
			
			$scrollBar = new JScrollBar(Constants.VERTICAL);
			this.addChild($scrollBar);
		}
		
		override protected function refreshData():void {
			$scrollBar.thumbPercent = $actualHeight / ($dataList.length * $itemHeight); 
			const pageSize:Number = MathUtil.floor($actualHeight / $itemHeight);
			$scrollBar.max = MathUtil.max(0, $dataList.length - pageSize);
			$scrollBar.pageSize = pageSize;
			$scrollBar.height = $actualHeight;
			scrollToSelection();
		}
		
		override protected function resize():void {
			$scrollBar.x = $actualWidth - $scrollBar.width;
			for each(var item:JListItem in $itemList) {
				this.removeChild(item);
			}
			var itemPool:Vector.<JListItem> = this.$itemList.slice();
			$itemList.length = 0;
			const numItems:int = Math.ceil($actualHeight / $itemHeight);
			for(var i:int = 0; i < numItems; i++) {
				item = itemPool.length ? itemPool.shift() : new JListItem();
				item.setLocation(0, i * $itemHeight);
				item.setSize(width, $itemHeight);
				this.$itemList[i] = item;
				item.addEventListener(MouseEvent.CLICK, onSelect);
				this.addChild(item);
			}
			DepthUtil.bringToTop($scrollBar);
		}
		
		override protected function onAddToStage(e:Event):void {
			super.onAddToStage(e);
			$scrollBar.addEventListener(Event.CHANGE, onScrollBarScroll);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			var i:int = $itemList.length;
			while (--i > -1) 
				$itemList[i].addEventListener(MouseEvent.CLICK, onSelect);
		}
		
		override protected function onRemoveFromStage(e:Event):void {
			super.onRemoveFromStage(e);
			$scrollBar.removeEventListener(Event.CHANGE, onScrollBarScroll);
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			var i:int = $itemList.length;
			while (--i > -1) 
				$itemList[i].removeEventListener(MouseEvent.CLICK, onSelect);
		}
		
		protected function updateItems():void {
			const offset:int = this.$scrollBar.value;
			const numItems:int = this.$itemList.length;
			const numData:int = this.$dataList.length;
			var item:JListItem;
			for(var i:int = 0; i < numItems; i++) {
				item = $itemList[i];
				item.setSize($actualWidth, $itemHeight);
				item.data = offset + i < numData ? this.$dataList[offset + i] : '';
				item.selected = offset + i == $selectedIndex;
			}
		}
		
		/**
		 * 如果选中的item不在视野中，挑战滚动条数值，直到选中的item出现
		 */
		protected function scrollToSelection():void {
			if(this.$selectedIndex == -1) {
				this.$scrollBar.value = 0;
			} else {
				const numItems:int = $itemList.length;
				if ($scrollBar.value + numItems < $selectedIndex) 
					$scrollBar.value = $selectedIndex - numItems + 1;
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
			this.$scrollBar.changeValue(0 - e.delta);
			updateItems();
		}
		
		protected function onSelect(event:Event):void {
			if (!(event.target is JListItem)) return;
			
			var target:JListItem = event.target as JListItem;
			//var offset:int = $scrollBar.getValue();
			const l:int = $itemList.length;
			for(var i:int = 0; i < l; i++) {
				if ($itemList[i] == target) continue; //this.$selectedIndex = i + offset;
				$itemList[i].selected = false;
			}
			target.selected = true;
			this.selectedItem = target;
			if (UIManager.stopPropagation) event.stopPropagation();
		}
		
	}

}