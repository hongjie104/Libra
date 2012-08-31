package org.libra.ui.base.interfaces {
	import flash.display.DisplayObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IComponent
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public interface IComponent {
		
		function removeFromParent(dispose:Boolean = false):void;
		
		function setLocation(x:Number, y:Number):void;
		
		function setSize(w:int, h:int):void;
		
		function setEnable(val:Boolean):void;
		
		function isEnable():Boolean;
		
		function setBackground(bg:DisplayObject):void
		
		function dispose():void;
		
		function toString():String;
	}
	
}