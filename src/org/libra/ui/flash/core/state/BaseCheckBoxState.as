package org.libra.ui.flash.core.state {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseCheckBoxState
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseCheckBoxState extends BaseButtonState implements ISelectState {
		
		protected var $selected:Boolean;
		
		public function BaseCheckBoxState() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toNormal():void {
			$selected ? toSelected() : super.toNormal();
		}
		
		override public function toMouseOver():void {
			$selected ? toSelected() : super.toMouseOver();
		}
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function toSelected():void {
			toMouseDown();
		}
		
		public function set selected(val:Boolean):void {
			$selected = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}