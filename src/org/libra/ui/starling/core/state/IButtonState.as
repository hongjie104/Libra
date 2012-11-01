package org.libra.ui.starling.core.state {
	import starling.display.DisplayObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IButtonState
	 * @author Eddie
	 * @qq 32968210
	 * @date 10/28/2012
	 * @version 1.0
	 * @see
	 */
	public interface IButtonState {
		
		function toNormal():void;
		
		function toMouseDown():void;
		
		function toMouseUp():void;
		
		function toMouseOver():void;
		
		function getDisplayObject():DisplayObject;
		
		function setSize(width:int, height:int):void;
		
	}
	
}