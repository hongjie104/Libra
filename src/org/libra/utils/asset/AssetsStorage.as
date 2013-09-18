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
		
		private static var $instance:AssetsStorage;
		
		private var $resMap:HashMap;
		
		private var $objMap:HashMap;
		
		private var $uiLoader:Loader;
		
		private var $loaderMax:LoaderMax;
		
		private var $configLoaderMax:LoaderMax;
		
		private var $loadQueue:Vector.<IAsset>;
		
		public function AssetsStorage(singleton:Singleton) {
			$resMap = new HashMap();
			$objMap = new HashMap();
			
			$loaderMax = new LoaderMax( { onComplete:onLoadComplete } );
			$loadQueue = new Vector.<IAsset>();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function init(uiLoader:Loader):void {
			this.$uiLoader = uiLoader;
		}
		
		public function getBitmapData(bmdName:String, loader:Loader = null, add:Boolean = true):BitmapData { 
			var bmd:BitmapData = $resMap.get(bmdName);
			if (bmd) return bmd;
			var c:Class = ReflectUtil.getDefinitionByNameFromLoader(bmdName, loader ? loader : $uiLoader) as Class;
			bmd = c ? new c() : null;
			if (add) {
				$resMap.put(bmdName, bmd);
			}
			return bmd;
		}
		
		public function getObj(key:*):*{
			return this.$objMap.get(key);
		}
		
		public function putObj(key:*, obj:*):void {
			this.$objMap.put(key, obj);
		}
		
		/**
		 * 开始加载游戏所需配置文件
		 */
		public function loadConfig(xmlList:XMLList):void {
			UIManager.getInstance().showLoading();
			const l:int = xmlList.length();
			this.$configLoaderMax = new LoaderMax( { onComplete:onLoadConfig, onProgress:onConfigProgress } );
			for (var i:int = 0; i < l; i += 1) {
				$configLoaderMax.append(new BinaryDataLoader(URI.CONFIG_URL + xmlList[i].@name, { name:xmlList[i].@id } ));
			}
			$configLoaderMax.load();
		}
		
		/**
		 * 开始加载进入游戏所需的资源
		 */
		public function loadRes(xmlList:XMLList):void {
			//先将加载配置文件的loader清除
			$configLoaderMax.dispose(true);
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
				var swfLoader:SWFLoader = new SWFLoader(asset.url, { autoDispose:true, onComplete:function():void { asset.doSthAfterLoad(swfLoader); }} );
				$loaderMax.append(swfLoader);
			}
			$loaderMax.load();
		}
		
		public static function getInstance():AssetsStorage {
			return $instance ||= new AssetsStorage(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
		private function onLoadComplete(evt:LoaderEvent):void {
			$loaderMax.empty(true, true);
		}
		
		private function onLoadConfig(evt:LoaderEvent):void {
			//配置文件加载完成，开始解析
			this.dispatchEvent(new LoaderEvent('loadConfig', evt.target));
		}
		
		private function onConfigProgress(evt:LoaderEvent):void {
			UIManager.getInstance().setLoadingProgress(evt.target.progress);
		}
		
		private function onLoadBaseRes(evt:LoaderEvent):void {
			//加载进入游戏所需资源完成后，可以进入游戏了
			UIManager.getInstance().closeLoading();
			dispatchEvent(new LoaderEvent('loadBaseRes', null));
		}
		
		private function onBaseResProgress(evt:LoaderEvent):void {
			UIManager.getInstance().setLoadingProgress(evt.target.progress);
		}
		
	}

}
final class Singleton{}