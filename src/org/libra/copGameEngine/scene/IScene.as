package org.libra.copGameEngine.scene {
	import org.libra.tick.ITickable;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IScene
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public interface IScene extends ITickable {
		
		function addLayer(layer:ILayer):void;
		
		function removeLayer(layer:ILayer):void;
		
		function show():void;
		
		function close():void;
		
		function get showing():Boolean;
		
		function get name():String;
		
		function set name(val:String):void;
		
	}
	
}