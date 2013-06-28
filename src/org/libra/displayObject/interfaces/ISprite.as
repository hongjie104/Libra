package org.libra.displayObject.interfaces {
	import flash.events.IEventDispatcher;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ISprite
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/09/2012
	 * @version 1.0
	 * @see
	 */
	public interface ISprite extends IEventDispatcher {
		
		function removeFromParent(destroy:Boolean = false):void;
		
		function get x():Number;
		
		function set x(x:Number):void;
		
		function get y():Number;
		
		function set y(y:Number):void;
		
		function get width():Number;
		
		function get height():Number;
		
		function dispose():void;
	}
	
}