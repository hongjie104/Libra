package org.libra.copGameEngine.model.basic {
	import org.libra.copGameEngine.entity.Entity;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class GameObject
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class GameObject extends Entity {
		
		protected var _id:String;
		
		protected var _type:int;
		
		protected var _des:String;
		
		public function GameObject() {
			super(null);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get id():String {
			return _id;
		}
		
		public function set id(value:String):void {
			_id = value;
		}
		
		public function get type():int {
			return _type;
		}
		
		public function set type(value:int):void {
			_type = value;
		}
		
		public function get des():String {
			return _des;
		}
		
		public function set des(value:String):void {
			_des = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}