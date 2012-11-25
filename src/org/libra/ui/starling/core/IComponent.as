package org.libra.ui.starling.core {
	import flash.geom.Point;
	import starling.display.DisplayObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IComponent
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/04/2012
	 * @version 1.0
	 * @see
	 */
	public interface IComponent {
		
		function addEventListener(type:String, listener:Function):void;
		
		function removeEventListener(type:String, listener:Function):void;
		
		function initToolTip():void;
		
		function removeFromParent(dispose:Boolean = false):void;
		
		function hitTest(localPoint:Point, forTouch:Boolean = false):DisplayObject;
		
		function get width():Number;
		
		function get height():Number;
		
		function set x(x:Number):void;
		
		function set y(y:Number):void;
	}
	
}