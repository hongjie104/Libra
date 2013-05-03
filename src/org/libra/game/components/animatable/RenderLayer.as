package org.libra.game.components.animatable {
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderLayer
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public final class RenderLayer {
		
		/**
		 * renderItemList中是否有任何RenderItem的bitmapData发生了变化
		 * 默认为true。否则RenderItem一开始不会对该层进行渲染，假如该层的BitmapData一直不变，
		 * 那么该层永远不会被渲染。
		 */
		private var needRender:Boolean;
		
		private var renderItemList:Vector.<RenderItem>;
		
		/**
		 * 当前层的bitmapData
		 */
		private var bmd:BitmapData;
		
		private var renderOffset:Point;
		
		private var $visible:Boolean;
		
		private var bitmapFrame:BitmapFrame;
		
		public function RenderLayer() {
			renderItemList = new Vector.<RenderItem>();
			renderOffset = new Point();
			$visible = true;
			needRender = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 设置该层大小。在JBitmap的addLayer（）方法中自动调用
		 * @param	w 宽度
		 * @param	h 高度
		 */
		public function setSize(w:int, h:int):void {
			if (bmd) bmd.dispose();
			if (w > 0 && h > 0) {
				bmd = new BitmapData(w, h, true, 0);
				setNeedRender(true);
			}
		}
		
		public function setNeedRender(boolean:Boolean):void {
			this.needRender = boolean;
			if (needRender) {
				if (bitmapFrame) this.bitmapFrame.setNeedRender(true);
			}
		}
		
		public function isNeedRender():Boolean {
			return this.needRender;
		}
		
		public function addItem(renderItem:RenderItem):void {
			this.addItemAt(renderItem);
		}
		
		public function addItemAt(renderItem:RenderItem, index:int = -1):void {
			if (this.renderItemList.indexOf(renderItem) == -1) {
				index = index < 0 ? renderItemList.length : (index > renderItemList.length ? renderItemList.length : index);
				this.renderItemList.splice(index, 0, renderItem);
				renderItem.setRenderLayer(this);
				setNeedRender(true);
			}
		}
		
		public function removeItem(renderItem:RenderItem):void {
			removeItemAt(this.renderItemList.indexOf(renderItem));
		}
		
		public function removeItemAt(index:int):void {
			if (index < 0 || index >= this.renderItemList.length) return;
			this.renderItemList.splice(index, 1);
			setNeedRender(true);
		}
		
		public function clearItems():void {
			for (var i:* in this.renderItemList) {
				renderItemList[i].setRenderLayer(null);
				renderItemList[i].dispose();
			}
			renderItemList.length = 0;
			this.setNeedRender(true);
		}
		
		/**
		 * 渲染
		 */
		public function render():void {
			if (needRender) {
				var item:RenderItem;
				var bmd:BitmapData;
				this.bmd.fillRect(this.bmd.rect, 0x00000000);
				for (var i:* in this.renderItemList) {
					item = renderItemList[i];
					if (item.visible) {
						renderOffset.x = item.x;
						renderOffset.y = item.y;
						bmd = item.bitmapData;
						if(bmd)
							this.bmd.copyPixels(bmd, bmd.rect, renderOffset, null, null, true);
						item.setNeedRender(false);
					}
				}
				needRender = false;
			}
		}
		
		/**
		 * 获取层的BitmapData
		 * @return
		 */
		public function getBmd():BitmapData {
			return this.bmd;
		}
		
		public function setBitmapFrame(bitmapFrame:BitmapFrame):void {
			this.bitmapFrame = bitmapFrame;
		}
		
		public function dispose():void {
			clearItems();
			if (this.bmd) {
				this.bmd.dispose();
				this.bmd = null;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters ans setters
		-------------------------------------------------------------------------------------------*/
		
		public function get visible():Boolean {
			return this.$visible;
		}
		
		public function set visible(value:Boolean):void {
			if (this.$visible != value) {
				this.$visible = value;
				this.setNeedRender(true);
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