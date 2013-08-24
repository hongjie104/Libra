package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class SocketEvent
	 * @author Eddie
	 * @qq 32968210
	 * @date 05/19/2013
	 * @version 1.0
	 * @see
	 */
	public final class SocketEvent extends BaseEvent {
		
		public static const SOCKET_EVENT:String = 'socketEvent';
		
		/**
		 * 发消息
		 */
		static public const SEND:String = "send";
		
		public function SocketEvent(subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(SOCKET_EVENT, subType, data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Event {
			return new SocketEvent($subType, $data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}