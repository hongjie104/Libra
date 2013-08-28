package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class MissionEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class MissionEvent extends BaseEvent {
		
		public static const MISSION_EVENT:String = 'missionEvent';
		
		public function MissionEvent(subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(MISSION_EVENT, subType, data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Event {
			return new MissionEvent(subType, data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}