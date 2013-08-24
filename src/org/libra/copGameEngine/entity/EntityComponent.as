package org.libra.copGameEngine.entity {
	/**
	 * <p>
	 * 实体组件
	 * </p>
	 *
	 * @class EntityComponent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public class EntityComponent implements IEntityComponent {
		
		protected var $isRegistered:Boolean;
		
		protected var $name:String;
		
		protected var $owner:IEntity;
		
		public function EntityComponent() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copEngine.entity.IEntityComponent */
		
		public function get owner():IEntity {
			return $owner;
		}
		
		public function set owner(value:IEntity):void {
			$owner = value;
		}
		
		public function get name():String {
			return $name;
		}
		
		public function get isRegistered():Boolean {
			return $isRegistered;
		}
		
		public function register(owner:IEntity, name:String):void {
			if($isRegistered)
				throw new Error("试图注册已经被注册过的组件:" + name);
			$name = name;
			$owner = owner;
			onAdd();
			$isRegistered = true;
		}
		
		public function unregister():void {
			if(!$isRegistered)
				throw new Error("试图注销没有被注册过的组件:" + name);
			$name = null;
			$owner = null;
			$isRegistered = false;
			onRemove();
		}
		
		public function reset():void {
			onReset();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		protected function onAdd():void {
			
		}
		
		protected function onRemove():void {
			
		}
		
		protected function onReset():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}