package org.libra.copGameEngine {
	import flash.display.DisplayObjectContainer;
	import org.libra.copGameEngine.controller.startup.CreateMediatorsCommand;
	import org.libra.copGameEngine.controller.startup.CreateModelsCommand;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class MainContext
	 * @author Eddie
	 * @date 20-11-2011
	 * @version 1.0
	 * @see
	 */
	
	public class MainContext extends Context {
		
		/**
		 * Constructor
		 */
		public function MainContext(contextView:DisplayObjectContainer) {
			super(contextView);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function startup():void { 
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateModelsCommand, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateMediatorsCommand, ContextEvent);
			super.startup();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
    }
	
}