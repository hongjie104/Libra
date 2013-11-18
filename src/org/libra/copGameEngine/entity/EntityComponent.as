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
		
		protected var _isRegistered:Boolean;
		
		protected var _name:String;
		
		protected var _owner:IEntity;
		
		public function EntityComponent() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copEngine.entity.IEntityComponent */
		
		public function get owner():IEntity {
			return _owner;
		}
		
		public function set owner(value:IEntity):void {
			_owner = value;
		}
		
		public function get name():String {
			return _name;
		}
		
		public function get isRegistered():Boolean {
			return _isRegistered;
		}
		
		public function register(owner:IEntity, name:String):void {
			if(_isRegistered)
				throw new Error("试图注册已经被注册过的组件:" + name);
			_name = name;
			_owner = owner;
			onAdd();
			_isRegistered = true;
		}
		
		public function unregister():void {
			if(!_isRegistered)
				throw new Error("试图注销没有被注册过的组件:" + name);
			_name = null;
			_owner = null;
			_isRegistered = false;
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