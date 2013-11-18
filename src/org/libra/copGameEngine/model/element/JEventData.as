package org.libra.copGameEngine.model.element {
	import org.libra.copGameEngine.model.basic.GameObject;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class JEventData
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class JEventData extends GameObject {
		
		private var _eventType:String;
		
		private var _eventValue:String;
		
		public function JEventData(eventType:String, eventValue:String = null) {
			super();
			_eventType = eventType;
			_eventValue = eventValue;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get eventType():String {
			return _eventType;
		}
		
		public function get eventValue():String {
			return _eventValue;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}