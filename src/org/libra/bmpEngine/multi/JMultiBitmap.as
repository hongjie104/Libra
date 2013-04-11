package org.libra.bmpEngine.multi {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	
	import org.libra.tick.ITickable;
	import org.libra.tick.Tick;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JMultiBitmapTest
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public class JMultiBitmap extends Bitmap implements ITickable {
		
		static public const ZERO_POINT:Point = new Point();
		
		//protected var baseBitmap:Bitmap;
		
		protected var $numChildren:int;
		
		private var layerList:Vector.<RenderLayer>;
		
		protected var $updated:Boolean;
		
		protected var $width:int;
		
		protected var $height:int;
		
		public function JMultiBitmap(width:int, height:int) { 
			super();
			//baseBitmap = new Bitmap(new BitmapData(width, height, true, 0x0));
			//this.addChild(baseBitmap);
			bitmapData = new BitmapData(width, height, true, 0x0);
			$width = width;
			$height = height;
			layerList = new Vector.<RenderLayer>();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			//if (this.baseBitmap.bitmapData) baseBitmap.bitmapData.dispose();
			//baseBitmap.bitmapData = new BitmapData(width, height, true, 0x0);
			if ($width != width || $height != height) {
				$width = width; $height = $height;
				if (this.bitmapData) bitmapData.dispose();
				bitmapData = new BitmapData(width, height, true, 0x0);
				for(var i:int = 0; i < this.$numChildren; i += 1)
					this.layerList[i].setSize(width, height);
				$updated = true;
			}
		}
		
		public function addLayer(layer:RenderLayer):void {
			this.layerList.push(layer);
			$updated = true;
			$numChildren += 1;
		}
		
		public function addLayerAt(layer:RenderLayer, index:int = -1):void {
			if (index < 0) layerList.unshift(layer);
			else if (index > $numChildren) layerList.push(layer);
			else layerList.splice(index, 0, layer);
			$numChildren += 1;
			$updated = true;
		}
		
		public function removeLayer(layer:RenderLayer, dispose:Boolean = false):void { 
			const index:int = this.layerList.indexOf(layer);
			if (index != -1) {
				layerList.splice(index, 1);
				$numChildren--;
				$updated = true;
				if (dispose) layer.dispose();
			}
		}
		
		public function removeLayerAt(index:int, dispose:Boolean = false):void { 
			var layer:RenderLayer;
			if (index > $numChildren) layer = layerList.pop();
			else if (index < 0) layer = layerList.shift();
			else layer = layerList.splice(index, 1)[0];
			$numChildren--;
			$updated = true;
			if (dispose) layer.dispose();
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			var needRender:Boolean;
			var l:int = $numChildren;
			var layer:RenderLayer;
			while (--l > -1) {
				layer = this.layerList[l];
				layer.render();
				if (layer.updated) {
					needRender = true;
				}
			}
			if (needRender || $updated) {
				bitmapData.lock();
				bitmapData.fillRect(bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < $numChildren; i += 1) {
					layer = layerList[i];
					if (layer.visible) {
						bitmapData.copyPixels(layer.bitmapData, layer.rect, ZERO_POINT, null, null, true);
						layer.updated = false;
					}
				}
				bitmapData.unlock();
				/*baseBitmap.bitmapData = layerList[0].bitmapData;
				layerList[0].updated = false;*/
				$updated = false;
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		protected function onAddToStage(event:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.getInstance().addItem(this);
		}
		
		protected function onRemoveFromStage(event:Event):void {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.getInstance().removeItem(this);
		}
		
	}

}