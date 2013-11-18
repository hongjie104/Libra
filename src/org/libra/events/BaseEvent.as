package org.libra.events {
	import flash.events.Event;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 03/30/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseEvent extends Event {
		
		protected var _subType:String;
		
		protected var _data:Object;
		
		public function BaseEvent(type:String, subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) { 
			super(type, bubbles, cancelable);
			this._subType = subType;
			this._data = data;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get subType():String {
			return _subType;
		}
		
		public function get data():Object {
			return _data;
		}
		
		override public function clone():Event {
			return new BaseEvent(type, _subType, _data, bubbles, cancelable);
		}
		
		override public function toString():String {
			return 'type = ' + type + ',subType = ' + _subType + ',data = ' + _data;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}