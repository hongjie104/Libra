package org.libra.copGameEngine.model {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.BinaryDataLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.sampler.getSize;
	import flash.utils.ByteArray;
	import org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection;
	import org.libra.log4a.Logger;
	import org.libra.URI;
	import org.robotlegs.mvcs.Actor;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class LoaderManager
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public class LoaderManager extends Actor {
		
		protected var loaderMax:LoaderMax;
		
		protected var dynamicLoadList:Vector.<IBmdCollection>;
		
		public function LoaderManager() {
			super();
			loaderMax = new LoaderMax();
			dynamicLoadList = new Vector.<IBmdCollection>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 加载配置文件
		 */
		public function loadConfig():void {
			//dispatch(new LoadingEvent(LoadingEvent.SHOW_LOADING));
			//const loaderMax:LoaderMax = new LoaderMax( { onProgress:loadConfigProgress, onComplete:loadConfigComplete, autoDispose:true } );
			//var l:int = LoaderType.configXMLList.length();
			//while(--l > -1) {
				//loaderMax.append(new SWFLoader(URI.CONFIG_RES_URL + LoaderType.configXMLList[l].@name, { name:LoaderType.configXMLList[l].@id.toString() } ));
			//}
			//loaderMax.unload();
			//loaderMax.load();
			new BinaryDataLoader(URI.RES_URL + 'floorConfig.libraCnf', { onComplete:loadConfigComplete, autoDispose:true } ).load();
			//new SWFLoader(URI.RES_URL + 'floorConfig.swf', { onComplete:loadConfigComplete, autoDispose:true } ).load();
		}
		
		public function dynamicLoad(list:Vector.<IBmdCollection>):void {
			var l:int = list.length;
			var url:String;
			var load:Boolean = false;
			while (--l > -1) {
				url = list[l].url;
				if (loaderMax.getLoader(url)) {
					continue;
				}
				loaderMax.append(new SWFLoader(list[l].url, { name:list[l].url, autoDispose:true, onComplete:dynamicLoadComplete } ));
				dynamicLoadList.push(list[l]);
				load = true;
			}
			if (load) loaderMax.load();
		}
		
		/*public function loadModule(url:String):void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadModuleComplete);
			var context:LoaderContext = new LoaderContext();
			//context.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain);
			context.applicationDomain = ApplicationDomain.currentDomain;
			loader.load(new URLRequest(url), context);
		}*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/*private function loadConfigProgress(evt:LoaderEvent):void {
			dispatch(new LoadingEvent(LoadingEvent.SET_PROGRESS, evt.target.progress));
		}*/
		
		private function loadConfigComplete(evt:LoaderEvent):void {
			/*const loader:SWFLoader = evt.target as SWFLoader;
			const display:* = loader.rawContent;
			const obj:* = display.CONFIG;
			trace(getSize(obj));*/
			
			const loader:BinaryDataLoader = evt.target as BinaryDataLoader;
			const byteArray:ByteArray = loader.content as ByteArray;
			byteArray.uncompress();
			const configLoader:Loader = new Loader();
			configLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadEd);
			configLoader.loadBytes(byteArray);
			
			Logger.info('配置文件加载成功');
		}
		
		private function onLoadEd(e:Event):void {
			const loader:LoaderInfo = e.target as LoaderInfo;
			loader.removeEventListener(Event.COMPLETE, onLoadEd);
			const array:Array = Object(loader.content).CONFIG;
			trace(getSize(array));
		}
		
		private function dynamicLoadComplete(evt:LoaderEvent):void {
			const swfLoader:SWFLoader = evt.target as SWFLoader;
			var i:int = dynamicLoadList.length;
			while (--i > -1) {
				if (dynamicLoadList[i].url == swfLoader.url) {
					const prop:IBmdCollection = dynamicLoadList.splice(i, 1)[0];
					prop.doSthAfterLoad(swfLoader);
					return;
				}
			}
		}
		
		/**
		 * 加载好了某一个模块
		 * @param	evt
		 */
		/*private function onLoadModuleComplete(evt:Event):void {
			const loaderInfo:LoaderInfo = evt.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, onLoadModuleComplete);
			//UIManager.getInstance().stage.addChild(loaderInfo.content);
			//org.libra.copEngine.view.login.Login
			Logger.info('模块加载完毕');
		}*/
	}

}