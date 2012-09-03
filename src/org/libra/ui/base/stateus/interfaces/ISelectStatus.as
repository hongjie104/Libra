package org.libra.ui.base.stateus.interfaces {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ICheckBoxStatus
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public interface ISelectStatus extends IButtonStatus {
		
		function setSelected(val:Boolean):void;
		
		function toSelected():void;
		
	}
	
}