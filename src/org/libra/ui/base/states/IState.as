package org.libra.ui.base.states {
	import flash.display.DisplayObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IState
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public interface IState {
		
		function setSize(w:int, h:int):void;
		
		function setResName(val:String):void;
		
		function getDisplayObject():DisplayObject;
		
		function toNormal():void;
		
		function toMouseOver():void;
		
		function toMouseOut():void;
		
		function toMouseDown():void;
		
		function toMouseUp():void;
		
		function dispose():void;
	}
	
}