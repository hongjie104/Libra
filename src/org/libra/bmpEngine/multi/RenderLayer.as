package org.libra.bmpEngine.multi {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.libra.utils.MathUtil;

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
	public class RenderLayer {
		
		private static const HELP_POINT:Point = new Point();
		
		protected var $rect:Rectangle;
		
		protected var itemList:Vector.<RenderSprite>;
		
		protected var $bitmapData:BitmapData;
		
		protected var $updated:Boolean;
		
		protected var $numChildren:int;
		
		protected var $visible:Boolean;
		
		public function RenderLayer(width:int, height:int) { 
			itemList = new Vector.<RenderSprite>();
			$bitmapData = new BitmapData(width, height, true, 0x0);
			$rect = $bitmapData.rect;
			$visible = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if($bitmapData) $bitmapData.dispose();
			$bitmapData = new BitmapData(width, height,true,0x0);
			$rect = $bitmapData.rect;
			$updated = true;
		}
		
		public function get visible():Boolean {
			return $visible;
		}
		
		public function setvisible(val:Boolean):void {
			if ($visible != val) {
				$visible = val;
				$updated = true;
			}
		}
		
		public function get bitmapData():BitmapData {
			return $bitmapData;
		}
		
		public function get rect():Rectangle {
			return $rect;
		}
		
		public function get updated():Boolean {
			return $updated;
		}
		
		public function set updated(value:Boolean):void {
			$updated = value;
		}
		
		public function addItem(item:RenderSprite):void {
			if (itemList.indexOf(item) == -1) {
				itemList.push(item);
				$numChildren += 1;
				$updated = true;
			}
		}
		
		public function addItemAt(item:RenderSprite, index:int = -1):void {
			if (index < 1) itemList.unshift(item);
			else if (index > $numChildren) itemList.push(item);
			else itemList.splice(index, 0, item);
			$numChildren += 1;
			$updated = true;
		}
		
		public function removeItem(item:RenderSprite, dispose:Boolean = false):void { 
			const index:int = itemList.indexOf(item);
			if (index != -1) {
				itemList.splice(index, 1);
				$numChildren--;
				if (dispose) item.dispose();
				$updated = true;
			}
		}
		
		public function removeItemAt(index:int = 0, dispose:Boolean = false):void {
			var item:RenderSprite;
			if (index > $numChildren) item = itemList.pop();
			else if (index < 0) item = itemList.shift();
			else item = itemList.splice(index, 1)[0];
			$numChildren--;
			if (dispose) item.dispose();
			$updated = true;
		}
		
		public function clearItem(dispose:Boolean = false):void {
			if (dispose) {
				const l:int = $numChildren;
				while (--l > -1)
					itemList[l].dispose();
			}
			this.itemList.length = 0;
			$numChildren = 0;
			$updated = true;
		}
		
		public function getRenderSpriteUnderPoint(point:Point):Vector.<RenderSprite>{
			var list:Vector.<RenderSprite> = new Vector.<RenderSprite>();
			var i:int = this.$numChildren;
			var sprite:RenderSprite;
			var index:int = 0;
			while(--i > -1){
				sprite = this.itemList[i];
				if(sprite.x <= point.x){
					if(sprite.y <= point.y){
						if(sprite.width + sprite.x >= point.x){
							if(sprite.height + sprite.y >= point.y){
								list[index++] = sprite;
							}
						}
					}
				}
			}
			return list;
		}
		
		public function indexOf(val:RenderSprite, fromIndex:int = 0):int {
			return this.itemList.indexOf(val, fromIndex);
		}
		
		public function swapDepths(item1:RenderSprite, item2:RenderSprite):void { 
			const index1:int = itemList.indexOf(item1);
			if (index1 > -1) {
				const index2:int = itemList.indexOf(item2);
				if (index2 > -1) {
					// swap their data
					itemList[index1] = item2;
					itemList[index2] = item1;
					$updated = true;
				}
			}
		}
		
		public function setChildIndex(child:RenderSprite,newIndex:int):void{
			const index:int = this.itemList.indexOf(child);
			if(index != -1){
				newIndex = MathUtil.min(MathUtil.max(0,newIndex),this.$numChildren);
				itemList.splice(index,1);
				itemList.splice(newIndex,0,child);
				$updated = true;
			}
		}
		
		public function sort(compareFunction:Function):void{
			this.itemList.sort(compareFunction);
			$updated = true;
		}
		
		public function render():void {
			var l:int = $numChildren;
			var needRender:Boolean = false;
			while (--l > -1) {
				if (itemList[l].updated) {
					needRender = true;
					break;
				}
			}
			if (needRender || $updated) {
				var item:RenderSprite;
				$bitmapData.lock();
				$bitmapData.fillRect($bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < $numChildren; i += 1) {
					item = itemList[i];
					if (item.visible && item.bitmapData) {
						HELP_POINT.x = item.x;
						HELP_POINT.y = item.y;
						$bitmapData.copyPixels(item.bitmapData, item.rect, HELP_POINT, null, null, true);
					}
					item.updated = false;
				}
				$bitmapData.unlock();
				$updated = true;
			}
		}
		
		public function dispose():void {
			clearItem(true);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}