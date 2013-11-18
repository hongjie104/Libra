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
		
		protected var _bitmapData:BitmapData;
		
		protected var _numChildren:int;
		
		protected var _layerList:Vector.<RenderLayer>;
		
		protected var _updated:Boolean;
		
		protected var _width:int;
		
		protected var _height:int;
		
		protected var _tickabled:Boolean;
		
		public function JMultiBitmapDataRender() {
			super();
			//bitmapData = new BitmapData(width, height, true, 0x0);
			//_width = width;
			//_height = height;
			_layerList = new Vector.<RenderLayer>();
			_tickabled = true;
			_name = 'JMultiBitmapDataRender';
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bitmapData(value:BitmapData):void {
			if (value) {
				_width = value.width; _height = value.height;
				for(var i:int = 0; i < this._numChildren; i += 1)
					this._layerList[i].setSize(_width, _height);
			}
			_bitmapData = value;
			_updated = true;
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
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
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
				_bitmapData.lock();
				_bitmapData.fillRect(_bitmapData.rect, 0x00000000);
				for (var i:int = 0; i < _numChildren; i += 1) {
					layer = _layerList[i];
					if (layer.visible) {
						_bitmapData.copyPixels(layer.bitmapData, layer.rect, ZERO_POINT, null, null, true);
						layer.updated = false;
					}
				}
				_bitmapData.unlock();
				_updated = false;
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