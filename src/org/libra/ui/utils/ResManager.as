package org.libra.ui.utils {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import org.libra.utils.HashMap;
	import org.libra.utils.ReflectUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ResManager
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public final class ResManager {
		
		private static var instance:ResManager;
		
		private var resMap:HashMap;
		
		private var objMap:HashMap;
		
		private var uiLoader:Loader;
		
		public function ResManager(singleton:Singleton) {
			resMap = new HashMap();
			objMap = new HashMap();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function init(uiLoader:Loader):void {
			this.uiLoader = uiLoader;
		}
		
		public function getBitmapData(bmdName:String, loader:Loader = null, add:Boolean = true):BitmapData { 
			var bmd:BitmapData = resMap.get(bmdName);
			if (bmd) return bmd;
			var c:Class = ReflectUtil.getDefinitionByNameFromLoader(bmdName, loader ? loader : uiLoader) as Class;
			bmd = c ? new c() : null;
			if (add) {
				resMap.put(bmdName, bmd);
			}
			return bmd;
		}
		
		public function getObj(key:*):*{
			return this.objMap.get(key);
		}
		
		public function putObj(key:*, obj:*):void {
			this.objMap.put(key, obj);
		}
		
		public static function getInstance():ResManager {
			return instance ||= new ResManager(new Singleton());
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}
class Singleton{}