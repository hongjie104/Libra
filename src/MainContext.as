package  {
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.mvcs.Context;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class MainContext
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/12/2012
	 * @version 1.0
	 * @see
	 */
	public final class MainContext extends Context {
		
		public function MainContext(contextView:DisplayObjectContainer) {
			super(contextView);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function startup():void { 
			//commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateModelsCommand, ContextEvent, true);
			//commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateMediatorsCommand, ContextEvent, true);
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