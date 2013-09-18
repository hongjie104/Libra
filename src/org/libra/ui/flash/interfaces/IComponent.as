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
		
		/**
		 * 强制性地发出事件，不管是否有此类事件的监听
		 * @param	event
		 * @return
		 */
		function dispatchEventForce(event:Event):Boolean;
		
		function initToolTip():void;
		
		function toXML():XML;
		
		function get parent():DisplayObjectContainer;
		
		function get stage():Stage;
		
		function get id():String;
		
	}
	
}