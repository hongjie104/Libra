package org.libra.copGameEngine.model {
	import com.greensock.loading.LoaderMax;
	import org.libra.copGameEngine.model.element.ILoaderProp;
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
		
		protected var dynamicLoadList:Vector.<ILoaderProp>;
		
		public function LoaderManager() {
			super();
			loaderMax = new LoaderMax();
			dynamicLoadList = new Vector.<ILoaderProp>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/**
		 * 加载配置文件
		 */
		//public function loadConfig():void {
			//dispatch(new LoadingEvent(LoadingEvent.SHOW_LOADING));
			//const loaderMax:LoaderMax = new LoaderMax( { onProgress:loadConfigProgress, onComplete:loadConfigComplete, autoDispose:true } );
			//var l:int = LoaderType.configXMLList.length();
			//while(--l > -1) {
				//loaderMax.append(new SWFLoader(URI.CONFIG_RES_URL + LoaderType.configXMLList[l].@name, { name:LoaderType.configXMLList[l].@id.toString() } ));
			//}
			//loaderMax.unload();
			//loaderMax.load();
		//}
		
		//public function dynamicLoad(list:Vector.<ILoaderProp>):void {
			//var l:int = list.length;
			//var url:String;
			//var load:Boolean = false;
			//while (--l > -1) {
				//url = list[l].url;
				//if (loaderMax.getLoader(url)) {
					//continue;
				//}
				//loaderMax.append(new SWFLoader(list[l].url, { name:list[l].url, autoDispose:true, onComplete:dynamicLoadComplete } ));
				//dynamicLoadList.push(list[l]);
				//load = true;
			//}
			//if (load) loaderMax.load();
		//}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		/*private function loadConfigProgress(evt:LoaderEvent):void {
			dispatch(new LoadingEvent(LoadingEvent.SET_PROGRESS, evt.target.progress));
		}
		
		private function loadConfigComplete(evt:LoaderEvent):void {
			const loaderMax:LoaderMax = evt.target as LoaderMax;
			//将加载好的配置文件取出，放在Config类里，然后卸载加载对象，释放内存
			Config.propConfig = loaderMax.getLoader('propConfig').rawContent.ary;
			Config.decoConfig = loaderMax.getLoader('decoConfig').rawContent.ary;
			loaderMax.dispose(true);
			dispatch(new LoadingEvent(LoadingEvent.CLOSE_LOADING));
			dispatch(new SceneEvent(SceneEvent.DRAW_ROOM));
		}
		
		private function dynamicLoadComplete(evt:LoaderEvent):void {
			const swfLoader:SWFLoader = evt.target as SWFLoader;
			var i:int = dynamicLoadList.length;
			while (--i > -1) {
				if (dynamicLoadList[i].url == swfLoader.url) {
					const prop:ILoaderProp = dynamicLoadList.splice(i, 1)[0];
					prop.doSthAfterLoad(prop, swfLoader);
					return;
				}
			}
		}*/
	}

}