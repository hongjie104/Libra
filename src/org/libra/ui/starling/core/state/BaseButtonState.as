package org.libra.ui.starling.core.state {
	import starling.display.DisplayObject;
	import starling.display.Quad;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseButtonState
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonState implements IButtonState {
		
		private var quad:Quad;
		
		public function BaseButtonState() {
			quad = new Quad(1, 1, 0xff0000);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.starling.ui.core.state.IButtonState */
		
		public function toNormal():void {
			quad.color = 0xff0000;
		}
		
		public function toMouseDown():void {
			quad.color = 0x00ff00;
		}
		
		public function toMouseUp():void {
			quad.color = 0x0000ff;
		}
		
		public function toMouseOver():void {
			quad.color = 0x0000ff;
		}
		
		public function getDisplayObject():DisplayObject {
			return quad;
		}
		
		public function setSize(width:int, height:int):void {
			quad.width = width;
			quad.height = height;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}