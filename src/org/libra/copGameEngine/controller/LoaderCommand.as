package org.libra.copGameEngine.controller {
	import org.libra.copGameEngine.events.LoaderEvent;
	import org.libra.copGameEngine.model.element.ILoaderProp;
	import org.libra.copGameEngine.model.LoaderManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoaderCommand
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/27/2013
	 * @version 1.0
	 * @see
	 */
	public class LoaderCommand extends Command {
		
		[Inject]
		public var event:LoaderEvent;
		
		[Inject]
		public var loaderManager:LoaderManager;
		
		public function LoaderCommand() {
		
		}
		
		override public function execute():void {
			switch(event.subType) {
				//case LoaderEvent.LOAD_CONFIG:
					//loaderManager.loadConfig();
					//break;
				/*case LoaderEvent.LOAD_MODULE:
					this.loaderManager.loadModule(event.data.toString());
					break;*/
				case LoaderEvent.DYNAMIC_LOAD:
					this.loaderManager.dynamicLoad(event.data as Vector.<ILoaderProp>);
					break;
			}
		}
	
	}

}