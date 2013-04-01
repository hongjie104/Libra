package org.robotlegs.utilities.lazy {
	import flash.events.Event;
	import org.libra.ui.flash.interfaces.IComponent;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LibraMediatorEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 04/01/2013
	 * @version 1.0
	 * @see
	 */
	public final class LibraMediatorEvent extends Event {
		
		/**
		 * Trigger when a view is added to stage.
		 */
		public static const VIEW_ADDED:String = "viewAdded";
		
		/**
		 * Trigger when a view is removed from stage.
		 */
        public static const VIEW_REMOVED:String = "viewRemoved";
		
		private var $view:IComponent;
		
		public function LibraMediatorEvent(type:String, view:IComponent) {
			super(type, true);
            $view = view;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get view():IComponent {
			return $view;
		}
		
		override public function clone():Event {
			return new LibraMediatorEvent(type, $view);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}