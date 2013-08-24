package org.libra.copGameEngine.entity {
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IEntity
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public interface IEntity {
		
		function addComponent(component:IEntityComponent, componentName:String):Boolean;
		
		function removeComponent(component:IEntityComponent):void;
		
		function getComponentByType(componentType:Class):IEntityComponent;
		
		function getComponentsByType(componentType:Class):Vector.<IEntityComponent>;
		
		function lookupComponentByName(componentName:String):IEntityComponent;
		
		function dispose():void;
		
		function get name():String;
		
	}
	
}