package org.libra.game.objects {
	import org.libra.game.interfaces.IAnimatable;
	import org.libra.game.interfaces.IMoveable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Avatar
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/13/2012
	 * @version 1.0
	 * @see
	 */
	public class Avatar extends ObjectTickable {
		
		private var animatable:IAnimatable;
		
		public function Avatar() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function setAnimatable(animatable:IAnimatable):void {
			this.animatable = animatable;
		}
		
		override public function tick(interval:int):void {
			animatable.update(interval);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
	}

}