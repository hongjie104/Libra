package org.robotlegs.utilities.lazy {
	import flash.events.Event;
	import org.libra.ui.flash.interfaces.IComponent;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LibraMediatorActivator
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public final class LibraMediatorActivator {
		
		private var view:IComponent;
		
		private var oneShot:Boolean;
		
		public function LibraMediatorActivator(view:IComponent, oneShot:Boolean = false) {
			this.view = view;
            this.oneShot = oneShot;
            if (view.stage)
				triggerActivateMediatorEvent();
            else
				view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		private function triggerActivateMediatorEvent():void { 
			view.dispatchEventForce(new LibraMediatorEvent(LibraMediatorEvent.VIEW_ADDED, view));
			view.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
        }
		
        private function triggerDeactivateMediatorEvent():void {
			view.dispatchEventForce(new LibraMediatorEvent(LibraMediatorEvent.VIEW_REMOVED, view));
			if (!oneShot)
				view.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
        }
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function addedToStageHandler(event:Event):void {
			view.removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			triggerActivateMediatorEvent();
        }
		
        private function removedFromStageHandler(event:Event):void {
			view.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageHandler);
			triggerDeactivateMediatorEvent();
		}
	}

}