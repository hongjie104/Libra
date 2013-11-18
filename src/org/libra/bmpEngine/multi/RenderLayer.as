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
		
		protected var _rect:Rectangle;
		
		protected var _itemList:Vector.<RenderSprite>;
		
		protected var _bitmapData:BitmapData;
		
		protected var _updated:Boolean;
		
		protected var _numChildren:int;
		
		protected var _visible:Boolean;
		
		public function RenderLayer(width:int, height:int) { 
			_itemList = new Vector.<RenderSprite>();
			_bitmapData = new BitmapData(width, height, true, 0x0);
			_rect = _bitmapData.rect;
			_visible = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			if(_bitmapData) _bitmapData.dispose();
			_bitmapData = new BitmapData(width, height,true,0x0);
			_rect = _bitmapData.rect;
			_updated = true;
		}
		
		public function get visible():Boolean {
			return _visible;
		}
		
		public function setvisible(val:Boolean):void {
			if (_visible != val) {
				_visible = val;
				_updated = true;
			}
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		
		public function get rect():Rectangle {
			return _rect;
		}
		
		public function get updated():Boolean {
			return _updated;
		}
		
		public function set updated(value:Boolean):void {
			_updated = value;
		}
		
		public function addItem(item:RenderSprite):void {
			if (_itemList.indexOf(item) == -1) {
				_itemList.push(item);
				_numChildren += 1;
				_updated = true;
			}
		}
		
		public function addItemAt(item:RenderSprite, index:int = -1):void {
			if (index < 1) _itemList.unshift(item);
			else if (index > _numChildren) _itemList.push(item);
			else _itemList.splice(index, 0, item);
			_numChildren += 1;
			_updated = true;
		}
		
		public function removeItem(item:RenderSprite, dispose:Boolean = false):void { 
			const index:int = _itemList.indexOf(item);
			if (index != -1) {
				_itemList.splice(index, 1);
				_numChildren--;
				if (dispose) item.dispose();
				_updated = true;
			}
		}
		
		public function removeItemAt(index:int = 0, dispose:Boolean = false):void {
			var item:RenderSprite;
			if (index > _numChildren) item = _itemList.pop();
			else if (index < 0) item = _itemList.shift();
			else item = _itemList.splice(index, 1)[0];
			_numChildren--;
			if (dispose) item.dispose();
			_updated = true;
		}
		
		public function clearItem(dispose:Boolean = false):void {
			if (dispose) {
				const l:int = _numChildren;
				while (--l > -1)
					_itemList[l].dispose();
			}
			this._itemList.length = 0;
			_numChildren = 0;
			_updated = true;
		}
		
		public function getRenderSpriteUnderPoint(point:Point):Vector.<RenderSprite>{
			var list:Vector.<RenderSprite> = new Vector.<RenderSprite>();
			var i:int = this._numChildren;
			var sprite:RenderSprite;
			var index:int = 0;
			while(--i > -1){
				sprite = this._itemList[i];
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
			return this._itemList.indexOf(val, fromIndex);
		}
		
		public function swapDepths(item1:RenderSprite, item2:RenderSprite):void { 
			const index1:int = _itemList.indexOf(item1);
			if (index1 > -1) {
				const index2:int = _itemList.indexOf(item2);
				if (index2 > -1) {
					// swap their data
					_itemList[index1] = item2;
					_itemList[index2] = item1;
					_updated = true;
				}
			}
		}
		
		public function setChildIndex(child:RenderSprite,newIndex:int):void{
			const index:int = this._itemList.indexOf(child);
			if(index != -1){
				newIndex = MathUtil.min(MathUtil.max(0,newIndex),this._numChildren);
				_itemList.splice(index,1);
				_itemList.splice(newIndex,0,child);
				_updated = true;
			}
		}
		
		public function sort(compareFunction:Function):void{
			this._itemList.sort(compareFunction);
			_updated = true;
		}
		
		public function render():void {
			var l:int = _numChildren;
			var needRender:Boolean = false;
			while (--l > -1) {
				if (_itemList[l].updated) {
					needRender = true;
					break;
				}
			}
			if (needRender || _updated) {
				var item:RenderSprite;
				_bitmapData.lock();
				_bitmapData.fillRect(_bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < _numChildren; i += 1) {
					item = _itemList[i];
					if (item.visible && item.bitmapData) {
						HELP_POINT.x = item.x;
						HELP_POINT.y = item.y;
						_bitmapData.copyPixels(item.bitmapData, item.rect, HELP_POINT, null, null, true);
					}
					item.updated = false;
				}
				_bitmapData.unlock();
				_updated = true;
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