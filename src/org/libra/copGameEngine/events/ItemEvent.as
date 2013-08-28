package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ItemEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class ItemEvent extends BaseEvent {
		
		public static const ITEM_EVENT:String = 'itemEvent';
		
		public function ItemEvent(subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(ITEM_EVENT, subType, data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Event {
			return new ItemEvent(subType, data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}