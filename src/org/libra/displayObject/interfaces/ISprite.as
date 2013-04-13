package org.libra.displayObject.interfaces {
	
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
	public interface ISprite {
		
		function removeFromParent(destroy:Boolean = false):void;
		
		function destroy():void;
		
		function dispose():void;
		
		function get x():Number;
		
		function set x(x:Number):void;
		
		function get y():Number;
		
		function set y(y:Number):void;
		
		function get width():Number;
		
		function set width(val:Number):void;
		
		function get height():Number;
		
		function set height(val:Number):void;
	}
	
}