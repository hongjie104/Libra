package org.libra.ui.base.stateus {
	import org.libra.ui.base.stateus.BaseButtonStatus;
	import org.libra.ui.base.stateus.interfaces.ICheckBoxStatus;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseCheckBoxStatus
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseCheckBoxStatus extends BaseButtonStatus implements ICheckBoxStatus {
		
		protected var selected:Boolean;
		
		public function BaseCheckBoxStatus() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toNormal():void {
			selected ? toSelected() : super.toNormal();
		}
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ICheckBoxStatus */
		
		public function toSelected():void {
			toMouseDown();
		}
		
		public function setSelected(val:Boolean):void {
			selected = val;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}