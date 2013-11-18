package org.libra.utils.asset {
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.BinaryDataLoader;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.EventDispatcher;
	import org.libra.ui.flash.managers.UIManager;
	import org.libra.URI;
	import org.libra.utils.HashMap;
	import org.libra.utils.ReflectUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class AssetsStorage
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public final class AssetsStorage extends EventDispatcher {
		
		private static var _instance:AssetsStorage;
		
		private var _resMap:HashMap;
		
		private var _objMap:HashMap;
		
		private var _uiLoader:Loader;
		
		private var _loaderMax:LoaderMax;
		
		private var _configLoaderMax:LoaderMax;
		
		private var _loadQueue:Vector.<IAsset>;
		
		public function AssetsStorage(singleton:Singleton) {
			_resMap = new HashMap();
			_objMap = new HashMap();
			
			_loaderMax = new LoaderMax( { onComplete:onLoadComplete } );
			_loadQueue = new Vector.<IAsset>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function init(uiLoader:Loader):void {
			this._uiLoader = uiLoader;
		}
		
		public function getBitmapData(bmdName:String, loader:Loader = null, add:Boolean = true):BitmapData { 
			var bmd:BitmapData = _resMap.get(bmdName);
			if (bmd) return bmd;
			var c:Class = ReflectUtil.getDefinitionByNameFromLoader(bmdName, loader ? loader : _uiLoader) as Class;
			bmd = c ? new c() : null;
			if (add) {
				_resMap.put(bmdName, bmd);
			}
			return bmd;
		}
		
		public function getObj(key:*):*{
			return this._objMap.get(key);
		}
		
		public function putObj(key:*, obj:*):void {
			this._objMap.put(key, obj);
		}
		
		/**
		 * 开始加载游戏所需配置文件
		 */
		public function loadConfig(xmlList:XMLList):void {
			UIManager.instance.showLoading();
			const l:int = xmlList.length();
			this._configLoaderMax = new LoaderMax( { onComplete:onLoadConfig, onProgress:onConfigProgress } );
			for (var i:int = 0; i < l; i += 1) {
				_configLoaderMax.append(new BinaryDataLoader(URI.CONFIG_URL + xmlList[i].@name, { name:xmlList[i].@id } ));
			}
			_configLoaderMax.load();
		}
		
		/**
		 * 开始加载进入游戏所需的资源
		 */
		public function loadRes(xmlList:XMLList):void {
			//先将加载配置文件的loader清除
			_configLoaderMax.dispose(true);
			if (xmlList) {
				const l:int = xmlList.length();
				const loaderMax:LoaderMax = new LoaderMax( { autoDispose:true, onComplete:onLoadBaseRes, onProgress:onBaseResProgress } );
				for (var i:int = 0; i < l; i += 1) {
					loaderMax.append(new BinaryDataLoader(URI.RES_URL + xmlList[i].@name, { name:xmlList[i].@id } ));
				}
				loaderMax.load();
			}
		}
		
		public function load(assetList:Vector.<IAsset>):void {
			const l:int = assetList.length;
			var asset:IAsset;
			for (var i:int = 0; i < l; i += 1) {
				asset = assetList[i];
				if (_loaderMax.getLoader(asset.url)) {
					continue;
				}
				var swfLoader:SWFLoader = new SWFLoader(asset.url, { autoDispose:true, onComplete:function():void { asset.doSthAfterLoad(swfLoader); }} );
				_loaderMax.append(swfLoader);
			}
			_loaderMax.load();
		}
		
		public static function get instance():AssetsStorage {
			return _instance ||= new AssetsStorage(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onLoadComplete(evt:LoaderEvent):void {
			_loaderMax.empty(true, true);
		}
		
		private function onLoadConfig(evt:LoaderEvent):void {
			//配置文件加载完成，开始解析
			this.dispatchEvent(new LoaderEvent('loadConfig', evt.target));
		}
		
		private function onConfigProgress(evt:LoaderEvent):void {
			UIManager.instance.setLoadingProgress(evt.target.progress);
		}
		
		private function onLoadBaseRes(evt:LoaderEvent):void {
			//加载进入游戏所需资源完成后，可以进入游戏了
			UIManager.instance.closeLoading();
			dispatchEvent(new LoaderEvent('loadBaseRes', null));
		}
		
		private function onBaseResProgress(evt:LoaderEvent):void {
			UIManager.instance.setLoadingProgress(evt.target.progress);
		}
		
	}

}
final class Singleton{}