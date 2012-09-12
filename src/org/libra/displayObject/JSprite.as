package org.libra.displayObject {
	import flash.display.Sprite;
	import org.libra.displayObject.interfaces.ISprite;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JSprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public class JSprite extends Sprite implements ISprite {
		
		public function JSprite() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function clearChildren():void {
			while (this.numChildren > 0) this.removeChildAt(0);
		}
		
		/* INTERFACE org.libra.displayObject.interfaces.ISprite */
		
		public function removeFromParent(dispose:Boolean = false):void {
			if (this.parent) {
				this.parent.removeChild(this);
				if (dispose) this.dispose();
			}
		}
		
		public function dispose():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}