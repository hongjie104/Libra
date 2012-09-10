package org.libra.utils {
	import flash.system.Capabilities;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class CapabilitiesUtil
	 * @author Eddie
	 * @qq 32968210
	 * @date 09-10-2012
	 * @version 1.0
	 * @see
	 */
	public final class CapabilitiesUtil {
		
		public function CapabilitiesUtil() {
			throw new Error('CapabilitiesUtil无法实例化!');
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * Returns a player and environment info string.
		 * @return
		 */
		public function getPlayerInfo():String { 
			return "Flash Platform: " + Capabilities.version + " / " + Capabilities.playerType + 
				((Capabilities.isDebugger) ? ' / Debugger' : '') + " / " + Capabilities.os + " / " + 
				Capabilities.screenResolutionX + "x" + Capabilities.screenResolutionY;
		}
		
		/**
		 * Determines if the SWF is running in the IDE.
		 * @return true if SWF is running in the Flash Player version used by the external player or test movie mode
		 * @author Aaron Clinger
		 * @author Shane McCartney
		 * @author David Nelson
		 */
		public function isIDE():Boolean {;
			return Capabilities.playerType == "External";
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}