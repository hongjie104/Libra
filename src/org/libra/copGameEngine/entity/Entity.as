package org.libra.copGameEngine.entity {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import org.libra.copGameEngine.events.EntityEvent;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class Entity
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public class Entity implements IEntity {
		
		protected var $name:String;
		
		protected var $componentList:Vector.<IEntityComponent>;
		
		protected var $eventDispatcher:EventDispatcher;
		
		public function Entity(name:String) { 
			super();
			this.$name = name;
			$componentList = new Vector.<IEntityComponent>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copEngine.entity.IEntity */
		
		public function addComponent(component:IEntityComponent, componentName:String):Boolean {
            if (!doAddComponent(component, componentName)) return false;
            component.register(this, componentName);
            doResetComponents();
            return true;
		}
		
		public function removeComponent(component:IEntityComponent):void {
            if (!doRemoveComponent(component)) return;
            component.unregister();
            doResetComponents();
		}
		
		public function getComponentByType(componentType:Class):IEntityComponent {
			var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i] is componentType) return $componentList[i];
			}
			return null;
		}
		
		public function getComponentsByType(componentType:Class):Vector.<IEntityComponent> {
			var result:Vector.<IEntityComponent> = new Vector.<IEntityComponent>();
			var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i] is componentType) result.push($componentList[i]);
			}
			return result;
		}
		
		public function getComponentByName(componentName:String):IEntityComponent {
			var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i].name == componentName) return $componentList[i];
			}
			return null;
		}
		
		public function get name():String {
			return $name;
		}
		
		public function set name(value:String):void {
			$name = value;
		}
		
		public function dispose():void {
			// Give listeners a chance to act before we start destroying stuff.
            dispatchEvent(new EntityEvent(EntityEvent.ENTITY_DISPOSE));
			
            // Unregister our components.
            for each(var component:IEntityComponent in $componentList) {
                if (component.isRegistered) component.unregister();
            }
			$componentList.length = 0;
		}
		
		public function dispatchEvent(event:Event):Boolean {
			if (!$eventDispatcher) $eventDispatcher = new EventDispatcher();
			if($eventDispatcher.hasEventListener(event.type))
				return $eventDispatcher.dispatchEvent(event);
			return false;
		}
		
		public function get eventDispatcher():EventDispatcher {
			return $eventDispatcher ||= new EventDispatcher();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function doAddComponent(component:IEntityComponent, componentName:String):Boolean {
            if (!componentName) {
				throw new Error('添加了一个没有Name的组件');
            }
            if (component.owner) {
				throw new Error('添加了一个有owner的组件:' + componentName);
            }
			
			var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i].name == componentName) {
					return false;
				}
			}
			
            component.owner = this;
            $componentList.push(component);
            return true;
        }
		
		private function doRemoveComponent(component:IEntityComponent):Boolean {
			if (component.owner != this) return false;
            var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i].name == component.name) {
					$componentList.splice(i, 1);
					return true;
				}
			}
            return false;
		}
		
		private function doResetComponents():void {
			var i:int = this.$componentList.length;
			while (--i > -1) {
				if ($componentList[i].isRegistered) $componentList[i].reset();
			}
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}