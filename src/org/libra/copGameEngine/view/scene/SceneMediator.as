package org.libra.copGameEngine.view.scene {
	import org.libra.copGameEngine.config.Config;
	import org.libra.copGameEngine.events.LoaderEvent;
	import org.robotlegs.mvcs.Mediator;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class SceneMediator
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/27/2013
	 * @version 1.0
	 * @see
	 */
	
	public class SceneMediator extends Mediator {
		
		[Inject]
		public var view:BaseScene;
		
		/**
		 * Constructor
		 */
		public function SceneMediator() {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		override public function onRegister():void {
			//eventMap.mapListener(eventDispatcher, StringEvent.RESIZE, _onResize, Event, false, 0, true);
			//加载登录模块
			//this.dispatch(new LoaderEvent(LoaderEvent.LOAD_MODULE, Config.LOGIN_MODULE));
		}
		
		override public function onRemove():void {
			eventMap.unmapListeners();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
	}
}