package org.libra.copGameEngine.basic {
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
		
		protected var $id:String;
		
		protected var $type:int;
		
		protected var $des:String;
		
		public function GameObject() {
			super(null);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get id():String {
			return $id;
		}
		
		public function set id(value:String):void {
			$id = value;
		}
		
		public function get type():int {
			return $type;
		}
		
		public function set type(value:int):void {
			$type = value;
		}
		
		public function get des():String {
			return $des;
		}
		
		public function set des(value:String):void {
			$des = value;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}