package org.libra.copGameEngine {
	import flash.display.DisplayObjectContainer;
	import org.robotlegs.core.IMediatorMap;
	import org.robotlegs.mvcs.Context;
	import org.robotlegs.utilities.lazy.LazyMediatorMap;
	
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
		/*override public function startup():void { 
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateModelsCommand, ContextEvent);
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, CreateMediatorsCommand, ContextEvent);
			super.startup();
		}*/
		
		override protected function get mediatorMap():IMediatorMap {
			return _mediatorMap ||= new LazyMediatorMap(contextView, createChildInjector(), reflector);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
    }
	
}