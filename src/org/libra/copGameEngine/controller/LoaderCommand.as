package org.libra.copGameEngine.controller {
	import org.libra.copGameEngine.events.LoaderEvent;
	import org.libra.copGameEngine.model.ILoaderObject;
	import org.libra.copGameEngine.model.LoaderManager;
	import org.robotlegs.mvcs.Command;
	
	/**
	 * ...
	 * @author Sandy
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
				case LoaderEvent.DYNAMIC_LOAD:
					this.loaderManager.dynamicLoad(event.data as Vector.<ILoaderObject>);
					break;
			}
		}
	
	}

}