package org.libra.ui.flash.events {
	import flash.events.Event;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class CheckBoxEvent
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class CheckBoxEvent extends Event {
		
		public static const SELECTED:String = 'selected';
		
		public function CheckBoxEvent(type:String) { 
			super(type);
		} 
		
		public override function clone():Event { 
			return new CheckBoxEvent(type);
		} 
		
		public override function toString():String { 
			return formatToString("CheckBoxEvent", "type"); 
		}
		
	}
	
}