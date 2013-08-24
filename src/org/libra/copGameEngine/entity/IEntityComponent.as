package org.libra.copGameEngine.entity {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IEntityComponent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public interface IEntityComponent {
		
		function get owner():IEntity;
		
		function set owner(value:IEntity):void;
		
		function get name():String;
		
		function get isRegistered():Boolean;
		
		function register(owner:IEntity, name:String):void;
		
		function unregister():void;
		
		function reset():void;
		
	}
	
}