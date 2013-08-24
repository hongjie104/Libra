package org.libra.copGameEngine.scene {
	import flash.display.DisplayObject;
	import org.libra.copGameEngine.core.JContainerObject;
	import org.libra.displayObject.JSprite;
	
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
	public class BaseScene extends JContainerObject implements IScene {
		
		protected var $showing:Boolean;
		
		protected var $tickabled:Boolean;
		
		protected var $layerList:Vector.<ILayer>;
		
		public function BaseScene() {
			super();
			$tickabled = true;
			$layerList = new Vector.<ILayer>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copEngine.scene.IScene */
		
		public function show():void {
			if ($showing) return;
			$showing = true;
			$tickabled = true;
		}
		
		public function close():void {
			if ($showing) {
				$showing = false;
				$tickabled = false;
			}
		}
		
		public function get showing():Boolean {
			return $showing;
		}
		
		public function tick(interval:int):void {
			for each(var layer:ILayer in this.$layerList) {
				layer.tick(interval);
			}
		}
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		public function addLayer(layer:ILayer):void {
			$layerList[$layerList.length] = layer;
			this.addChild(layer as DisplayObject);
		}
		
		public function removeLayer(layer:ILayer):void {
			var index:int = layerList.indexOf(layer);
			if (index != -1)
				layerList.splice(index, 1);
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