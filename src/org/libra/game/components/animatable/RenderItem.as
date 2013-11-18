package org.libra.game.components.animatable {
	import flash.display.BitmapData;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class RenderItem
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public class RenderItem {
		
		private var _bitmapData:BitmapData;
		
		/**
		 * 所在的渲染层
		 */
		private var renderLayer:RenderLayer;
		
		/**
		 * 是否可见
		 */
		private var _visible:Boolean;
		
		private var _x:int;
		
		private var _y:int;
		
		public function RenderItem(bitmapData:BitmapData, renderLayer:RenderLayer = null) { 
			this.bitmapData = bitmapData;
			if(renderLayer) renderLayer.addItem(this);
			visible = true;
			_x = _y = 0;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function set bitmapData(bmd:BitmapData):void {
			this._bitmapData = bmd;
			setNeedRender(true);
		}
		
		/**
		 * 获取Bitmapdata
		 * @return
		 */
		public function get bitmapData():BitmapData {
			return this._bitmapData;
		}
		
		public function setRenderLayer(renderLayer:RenderLayer):void {
			this.renderLayer = renderLayer;
		}
		
		public function setNeedRender(val:Boolean):void {
			if (val) {
				if(this.renderLayer)
					this.renderLayer.setNeedRender(true);
			}
		}
		
		public function dispose():void {
			if (this.renderLayer) this.renderLayer.removeItem(this);
			this._bitmapData.dispose();
			this._bitmapData = null;
		}
		
		/*-----------------------------------------------------------------------------------------
		Getters ans setters
		-------------------------------------------------------------------------------------------*/
		
		public function get x():int { 
			return _x; 
		}
		
		public function set x(value:int):void {
			if (_x != value) {
				_x = value;
				setNeedRender(true);
			}
		}
		
		public function get y():int { 
			return _y; 
		}
		
		public function set y(value:int):void {
			if (_y != value) {
				_y = value;
				setNeedRender(true);
			}
		}
		
		public function set visible(value:Boolean):void {
			if (this._visible != value) {
				this._visible = value;
				this.setNeedRender(true);
			}
		}
		
		public function get visible():Boolean {
			return this._visible;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}