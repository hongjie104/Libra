package org.libra.ui.flash.interfaces {
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
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
		
		function dispatchEventForce(event:Event):Boolean;
		
		function initToolTip():void;
		
		function get parent():DisplayObjectContainer;
		
		function get stage():Stage;
	}
	
}