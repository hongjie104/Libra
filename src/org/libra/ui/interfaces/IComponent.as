package org.libra.ui.interfaces {
	import flash.display.DisplayObjectContainer;
	import org.libra.displayObject.interfaces.ISprite;
	
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
	public interface IComponent extends ISprite {
		
		function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void;
		
		function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void;
		
		function initToolTip():void;
		
		function get x():Number;
		
		function set x(x:Number):void;
		
		function get y():Number;
		
		function set y(y:Number):void;
		
		function get width():Number;
		
		function set width(val:Number):void;
		
		function get height():Number;
		
		function set height(val:Number):void;
		
		function get parent():DisplayObjectContainer;
	}
	
}