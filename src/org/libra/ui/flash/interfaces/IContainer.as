package org.libra.ui.flash.interfaces {
	import flash.display.DisplayObject;
	import org.libra.ui.flash.core.Component;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IContainer
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/07/2012
	 * @version 1.0
	 * @see
	 */
	public interface IContainer {
		
		function hasComponent(child:IComponent):Boolean;
		
		function append(child:IComponent):IComponent;
		
		function appendAt(child:IComponent, index:int):IComponent;
		
		function appendAll(...rest):void;
		
		function remove(child:IComponent, dispose:Boolean = false):IComponent;
		
		function removeAt(index:int, dispose:Boolean = false):IComponent;
		
		function removeAll(dispose:Boolean, ...rest):void;
		
		function clear(dispose:Boolean = false):void;
		
		function bringToTop(child:DisplayObject):void;
		
		function bringToBottom(child:DisplayObject):void;
		
		function get numComponent():int;
	}
	
}