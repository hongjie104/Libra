package org.libra.copGameEngine.scene {
	import org.libra.copGameEngine.core.JContainerObject;
	import org.libra.displayObject.JSprite;
	import org.libra.tick.ITickable;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseLayer
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseLayer extends JContainerObject implements ILayer, ITickable {
		
		private var $tickabled:Boolean;
		
		public function BaseLayer() {
			super();
			$tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			
		}
		
		public function get tickabled():Boolean {
			return $tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			$tickabled = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}