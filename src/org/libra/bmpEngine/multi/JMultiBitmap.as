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
		
		protected var _numChildren:int;
		
		private var _layerList:Vector.<RenderLayer>;
		
		protected var _updated:Boolean;
		
		protected var _width:int;
		
		protected var _height:int;
		
		protected var _tickabled:Boolean;
		
		public function JMultiBitmap(width:int, height:int) { 
			super();
			_tickabled = true;
			//baseBitmap = new Bitmap(new BitmapData(width, height, true, 0x0));
			//this.addChild(baseBitmap);
			bitmapData = new BitmapData(width, height, true, 0x0);
			_width = width;
			_height = height;
			_layerList = new Vector.<RenderLayer>();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setSize(width:int, height:int):void {
			//if (this.baseBitmap.bitmapData) baseBitmap.bitmapData.dispose();
			//baseBitmap.bitmapData = new BitmapData(width, height, true, 0x0);
			if (_width != width || _height != height) {
				_width = width; _height = height;
				if (this.bitmapData) bitmapData.dispose();
				bitmapData = new BitmapData(width, height, true, 0x0);
				for(var i:int = 0; i < this._numChildren; i += 1)
					this._layerList[i].setSize(width, height);
				_updated = true;
			}
		}
		
		public function addLayer(layer:RenderLayer):void {
			this._layerList.push(layer);
			_updated = true;
			_numChildren += 1;
		}
		
		public function addLayerAt(layer:RenderLayer, index:int = -1):void {
			if (index < 0) _layerList.unshift(layer);
			else if (index > _numChildren) _layerList.push(layer);
			else _layerList.splice(index, 0, layer);
			_numChildren += 1;
			_updated = true;
		}
		
		public function removeLayer(layer:RenderLayer, dispose:Boolean = false):void { 
			const index:int = this._layerList.indexOf(layer);
			if (index != -1) {
				_layerList.splice(index, 1);
				_numChildren--;
				_updated = true;
				if (dispose) layer.dispose();
			}
		}
		
		public function removeLayerAt(index:int, dispose:Boolean = false):void { 
			var layer:RenderLayer;
			if (index > _numChildren) layer = _layerList.pop();
			else if (index < 0) layer = _layerList.shift();
			else layer = _layerList.splice(index, 1)[0];
			_numChildren--;
			_updated = true;
			if (dispose) layer.dispose();
		}
		
		public function getRenderSpriteUnderPoint(point:Point):Vector.<RenderSprite>{
			var list:Vector.<RenderSprite> = new Vector.<RenderSprite>();
			var i:int = this._numChildren;
			while(--i > -1){
				list = list.concat(this._layerList[i].getRenderSpriteUnderPoint(point));
			}
			return list;
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			var needRender:Boolean;
			var l:int = _numChildren;
			var layer:RenderLayer;
			while (--l > -1) {
				layer = this._layerList[l];
				layer.render();
				if (layer.updated) {
					needRender = true;
				}
			}
			if (needRender || _updated) {
				bitmapData.lock();
				bitmapData.fillRect(bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < _numChildren; i += 1) {
					layer = _layerList[i];
					if (layer.visible) {
						bitmapData.copyPixels(layer.bitmapData, layer.rect, ZERO_POINT, null, null, true);
						layer.updated = false;
					}
				}
				bitmapData.unlock();
				/*baseBitmap.bitmapData = _layerList[0].bitmapData;
				_layerList[0].updated = false;*/
				_updated = false;
			}
		}
		
		override public function get width():Number{
			return _width;
		}
		
		override public function get height():Number{
			return _height;
		}
		
		public function get tickabled():Boolean{
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void{
			_tickabled = value;
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
			Tick.instance.addItem(this);
		}
		
		protected function onRemoveFromStage(event:Event):void {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddToStage);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			Tick.instance.removeItem(this);
		}
	}

}