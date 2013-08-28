package org.libra.copGameEngine.controller {
	import org.libra.copGameEngine.events.MissionEvent;
	import org.libra.copGameEngine.model.MissionManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class MissionCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	
	public class MissionCommand extends Command {
		
		[Inject]
		public var event:MissionEvent;
		
		[Inject]
		public var missionManager:MissionManager;
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
        override public function execute():void {
			switch(event.subType) {
				
			}
        }
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
    }
	
}