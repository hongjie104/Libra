package org.libra.bmpEngine.multiTest {
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderLayerTest
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public class RenderLayerTest {
		
		protected var itemList:Vector.<RenderItemTest>;
		
		protected var $bitmapData:BitmapData;
		
		protected var $rebuild:Boolean;
		
		protected var $numChild:int;
		
		public function RenderLayerTest() {
			itemList = new Vector.<RenderItemTest>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get bitmapData():BitmapData {
			return $bitmapData;
		}
		
		public function get rebuild():Boolean {
			return $rebuild;
		}
		
		public function set rebuild(value:Boolean):void {
			$rebuild = value;
		}
		
		public function addItem(item:RenderItemTest):void {
			if (itemList.indexOf(item) != -1) {
				itemList.push(item);
				$numChild += 1;
			}
		}
		
		public function addItemAt(item:RenderItemTest, index:int = -1):void {
			if (index < 1) itemList.unshift(item);
			else if (index > itemList.length) itemList.push(item);
			else itemList.splice(index, 0, item);
			$numChild += 1;
		}
		
		public function removeItem(item:RenderItemTest, dispose:Boolean = false):void { 
			const index:int = itemList.indexOf(item);
			if (index > -1) {
				itemList.splice(index, 1);
				$numChild--;
				if (dispose) item.dispose();
			}
		}
		
		public function removeItemAt(item:RenderItemTest, index:int = 0, dispose:Boolean = false):void {
			if (index > itemList.length) itemList.pop();
			else if (index < 0) itemList.shift();
			else itemList.splice(index, 1);
			$numChild--;
			if (dispose) item.dispose();
		}
		
		public function clearItem(dispose:Boolean = false):void {
			if (dispose) {
				const l:int = itemList.length;
				while (--l > -1)
					itemList[l].dispose();
			}
			this.itemList.length = 0;
			$numChild = 0;
		}
		
		public function swapDepths(item1:RenderItemTest, item2:RenderItemTest):void { 
			const index1:int = itemList.indexOf(item1);
			if (index1 > -1) {
				const index2:int = itemList.indexOf(item2);
				if (index2 > -1) {
					// swap their data
					itemList[index1] = item2;
					itemList[index2] = item1;
				}
			}
		}
		
		public function render():void {
			var l:int = $numChild;
			var needRender:Boolean = false;
			while (--l > -1) {
				if (itemList[l].rebuild) {
					needRender = true;
					break;
				}
			}
			if (needRender) {
				var item:RenderItemTest;
				var point:Point = new Point();
				$bitmapData.lock();
				for (var i:int = 0; i < l; i += 1) {
					item = itemList[i];
					if (item.visible) {
						point.x = item.x;
						point.y = item.y;
						$bitmapData.copyPixels(item.bitmapData, item.rect, point, null, null, true);
					}
				}
				$bitmapData.unlock();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}