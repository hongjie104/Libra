package org.libra.copGameEngine.controller {
	import org.libra.copGameEngine.events.ItemEvent;
	import org.libra.copGameEngine.model.ItemManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ItemCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	
	public class ItemCommand extends Command {
		
		[Inject]
		public var event:ItemEvent;
		
		[Inject]
		public var itemManager:ItemManager;
		
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