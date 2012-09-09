package org.libra.bmpEngine {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Point;
	import org.libra.displayObject.JSprite;
	import org.libra.tick.ITickEnabled;
	import org.libra.tick.Tick;
	/**
	 * <p>
	 * 有很多层的可视对象
	 * </p>
	 *
	 * @class JMultiBitmap
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public class JMultiBitmap extends JSprite implements ITickEnabled {
		
		/**
		 * 公共静态常量：原点，x和y都是0的点。
		 */
		private static const ZERO_POINT:Point = new Point();
		
		/**
		 * 层次数组。
		 */
		private var layerList:Vector.<RenderLayer>;
		
		/**
		 * 图片的宽度
		 */
		private var $width:int;
		
		/**
		 * 图片的高度
		 */
		private var $height:int;
		
		private var needRender:Boolean;
		
		private var baseBitmap:Bitmap;
		
		public function JMultiBitmap(width:int, height:int) { 
			super();
			this.$width = width;
			this.$height = height;
			baseBitmap = new Bitmap(new BitmapData($width, $height, true, 0))
			this.addChild(baseBitmap);
			layerList = new Vector.<RenderLayer>();
			needRender = true;
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 增加层
		 * @param	l 将要被增加的层
		 */
		public function addLayer(l:RenderLayer):void {
			addLayerAt(l);
		}
		
		public function addLayerAt(l:RenderLayer, index:int = -1):void {
			if (this.layerList.indexOf(l) == -1) {
				index = index < 0 ? this.layerList.length : (index > layerList.length ? layerList.length : index);
				this.layerList.splice(index, 0, l);
				l.setMultiBitmap(this);
				l.setSize($width, $height);
				needRender = true;
			}
		}
		
		/**
		 * 移除层
		 * @param	l 将要被移除的层
		 */
		public function removeLayer(l:RenderLayer):void {
			removeLayerAt(this.layerList.indexOf(l));
		}
		
		public function removeLayerAt(index:int):void {
			if (index < 0 || index >= this.layerList.length) return;
			this.layerList.splice(index, 1);
			needRender = true;
		}
		
		public function setNeedRender(boolean:Boolean):void {
			this.needRender = boolean;
		}
		
		public function setSize(w:int, h:int):void {
			if (this.baseBitmap.bitmapData) baseBitmap.bitmapData.dispose();
			$width = w;
			$height = h;
			baseBitmap.bitmapData = new BitmapData(w, h, true, 0);
			for each(var l:RenderLayer in layerList) {
				l.setSize(w, h);	
			}
		}
		
		/**
		 * 渲染
		 */
		public function tick(interval:int):void {
			if (needRender) {
				this.baseBitmap.bitmapData.fillRect(baseBitmap.bitmapData.rect, 0x00000000);
				var layer:RenderLayer;
				for (var i:* in layerList) {
					layer = layerList[i];
					layer.render();
					if (layer.visible) {
						var bmd:BitmapData = layer.getBmd();
						if(bmd)
							baseBitmap.bitmapData.copyPixels(bmd, bmd.rect, ZERO_POINT, null, null, true);
					}
					layer.setNeedRender(false);
				}
				needRender = false;
			}
		}
		
		override public function dispose():void {
			this.baseBitmap.bitmapData.dispose();
			for (var i:* in this.layerList) {
				layerList[i].dispose();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		private function onAddToStage(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.getInstance().addItem(this);
		}
		
		private function onRemoveFromStage(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			Tick.getInstance().removeItem(this);
		}
	}

}