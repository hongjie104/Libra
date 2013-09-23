package org.libra.ui.flash.interfaces {
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IDragable
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/02/2012
	 * @version 1.0
	 * @see
	 */
	public interface IDragabled {
		
		function set dragabled(val:Boolean):void;
		
		function get dragBmd():BitmapData;
		
		function removeFromParent(dispose:Boolean = false):void;
		
		function get x():Number;
		
		function get y():Number;
		
		function get parent():DisplayObjectContainer;
		
	}
	
}