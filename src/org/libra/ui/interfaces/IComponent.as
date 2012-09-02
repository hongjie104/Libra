package org.libra.ui.interfaces {
	import flash.display.DisplayObjectContainer;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IComponent
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public interface IComponent {
		
		function removeFromParent(dispose:Boolean = false):void
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		
		function initToolTip():void;
		
		function getWidth():int;
		
		function getHeight():int;
		
		function dispose():void;
		
		function get x():Number;
		
		function set x(x:Number):void;
		
		function get y():Number;
		
		function set y(y:Number):void;
		
		function get parent():DisplayObjectContainer;
	}
	
}