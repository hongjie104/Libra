package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class EntityEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/19/2013
	 * @version 1.0
	 * @see
	 */
	public final class EntityEvent extends BaseEvent {
		
		public static const ENTITY_EVENT:String = 'entityEvent';
		
		public static const ENTITY_DISPOSE:String = 'EntityDestroyed';
		
		public function EntityEvent(subType:String, data:Object = null) {
			super(ENTITY_EVENT, subType, data);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Event {
			return new EntityEvent(_subType, _data);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}