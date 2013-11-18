package org.libra.copGameEngine.view.scene {
	import flash.display.DisplayObject;
	import org.libra.displayObject.JSprite;
	import org.robotlegs.utilities.lazy.LazyMediatorActivator;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseScene
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseScene extends JSprite implements IScene {
		
		protected var _showing:Boolean;
		
		protected var _tickabled:Boolean;
		
		protected var _layerList:Vector.<ILayer>;
		
		public function BaseScene() {
			super();
			new LazyMediatorActivator(this);
			_tickabled = true;
			_layerList = new Vector.<ILayer>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copEngine.scene.IScene */
		
		public function show():void {
			if (_showing) return;
			_showing = true;
			_tickabled = true;
		}
		
		public function close():void {
			if (_showing) {
				_showing = false;
				_tickabled = false;
			}
		}
		
		public function get showing():Boolean {
			return _showing;
		}
		
		public function tick(interval:int):void {
			for each(var layer:ILayer in this._layerList) {
				layer.tick(interval);
			}
		}
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		public function addLayer(layer:ILayer):void {
			_layerList[_layerList.length] = layer;
			this.addChild(layer as DisplayObject);
		}
		
		public function removeLayer(layer:ILayer):void {
			var index:int = _layerList.indexOf(layer);
			if (index != -1)
				_layerList.splice(index, 1);
			this.removeChild(layer as DisplayObject);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}