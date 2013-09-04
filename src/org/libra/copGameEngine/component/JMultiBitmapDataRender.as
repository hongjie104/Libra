package org.libra.copGameEngine.component {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import org.libra.bmpEngine.multi.RenderLayer;
	import org.libra.bmpEngine.multi.RenderSprite;
	import org.libra.copGameEngine.entity.EntityComponent;
	import org.libra.tick.ITickable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JMultiBitmapDataRender
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class JMultiBitmapDataRender extends EntityComponent implements ITickable, IBitmapDataRender {
		
		static public const ZERO_POINT:Point = new Point();
		
		protected var $bitmapData:BitmapData;
		
		protected var $numChildren:int;
		
		protected var $layerList:Vector.<RenderLayer>;
		
		protected var $updated:Boolean;
		
		protected var $width:int;
		
		protected var $height:int;
		
		protected var $tickabled:Boolean;
		
		public function JMultiBitmapDataRender() {
			super();
			//bitmapData = new BitmapData(width, height, true, 0x0);
			//$width = width;
			//$height = height;
			$layerList = new Vector.<RenderLayer>();
			$tickabled = true;
			$name = 'JMultiBitmapDataRender';
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				$width = value.width; $height = value.height;
				for(var i:int = 0; i < this.$numChildren; i += 1)
					this.$layerList[i].setSize($width, $height);
			}
			$bitmapData = value;
			$updated = true;
		}
		
		public function addLayer(layer:RenderLayer):void {
			this.$layerList.push(layer);
			$updated = true;
			$numChildren += 1;
		}
		
		public function addLayerAt(layer:RenderLayer, index:int = -1):void {
			if (index < 0) $layerList.unshift(layer);
			else if (index > $numChildren) $layerList.push(layer);
			else $layerList.splice(index, 0, layer);
			$numChildren += 1;
			$updated = true;
		}
		
		public function removeLayer(layer:RenderLayer, dispose:Boolean = false):void { 
			const index:int = this.$layerList.indexOf(layer);
			if (index != -1) {
				$layerList.splice(index, 1);
				$numChildren--;
				$updated = true;
				if (dispose) layer.dispose();
			}
		}
		
		public function removeLayerAt(index:int, dispose:Boolean = false):void { 
			var layer:RenderLayer;
			if (index > $numChildren) layer = $layerList.pop();
			else if (index < 0) layer = $layerList.shift();
			else layer = $layerList.splice(index, 1)[0];
			$numChildren--;
			$updated = true;
			if (dispose) layer.dispose();
		}
		
		public function getRenderSpriteUnderPoint(point:Point):Vector.<RenderSprite>{
			var list:Vector.<RenderSprite> = new Vector.<RenderSprite>();
			var i:int = this.$numChildren;
			while(--i > -1){
				list = list.concat(this.$layerList[i].getRenderSpriteUnderPoint(point));
			}
			return list;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		public function tick(interval:int):void {
			var needRender:Boolean;
			var l:int = $numChildren;
			var layer:RenderLayer;
			while (--l > -1) {
				layer = this.$layerList[l];
				layer.render();
				if (layer.updated) {
					needRender = true;
				}
			}
			if (needRender || $updated) {
				$bitmapData.lock();
				$bitmapData.fillRect($bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < $numChildren; i += 1) {
					layer = $layerList[i];
					if (layer.visible) {
						$bitmapData.copyPixels(layer.bitmapData, layer.rect, ZERO_POINT, null, null, true);
						layer.updated = false;
					}
				}
				$bitmapData.unlock();
				$updated = false;
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