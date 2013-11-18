package org.libra.game.layers {
	import org.libra.displayObject.JSprite;
	import org.libra.game.Camera;
	import org.libra.game.interfaces.ILayer;
	import org.libra.tick.ITickable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseLayer
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/13/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseLayer extends JSprite implements ITickable, ILayer {
		
		private var camera:Camera;
		
		private var _tickabled:Boolean;
		
		public function BaseLayer() {
			super();
			_tickabled = true;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function tick(interval:int):void {
			if (camera) camera.render();
		}
		
		/* INTERFACE org.libra.tick.ITickable */
		
		public function get tickabled():Boolean {
			return _tickabled;
		}
		
		public function set tickabled(value:Boolean):void {
			_tickabled = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}