package org.libra.copGameEngine.events {
	import flash.events.Event;
	import org.libra.events.BaseEvent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoaderEvent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class LoaderEvent extends BaseEvent {
		
		public static const LOADER_EVENT:String = 'loaderEvent';
		
		/**
		 * 动态加载
		 */
		static public const DYNAMIC_LOAD:String = "dynamicLoad";
		
		/**
		 * 开始加载配置文件
		 */
		//static public const LOAD_CONFIG:String = "loadConfig";
		
		public function LoaderEvent(subType:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(LOADER_EVENT, subType, data, bubbles, cancelable);
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function clone():Event {
			return new LoaderEvent($subType, $data, bubbles, cancelable);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}