package org.libra.ui.flash.interfaces {
	import flash.display.Loader;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IPanel
	 * @author Eddie
	 * @qq 32968210
	 * @date 11/03/2012
	 * @version 1.0
	 * @see
	 */
	public interface IPanel {
		
		function show():void;
		
		function close(tween:Boolean = true, destroy:Boolean = false):void;
		
		function showSwitch():void;
		
		function get showing():Boolean;
		
		function get loader():Loader;
	}
	
}