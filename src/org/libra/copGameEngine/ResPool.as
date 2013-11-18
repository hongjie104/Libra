package org.libra.copGameEngine {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import org.libra.utils.HashMap;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class ResPool
	 * @author Eddie
	 * @qq 32968210
	 * @date 04/29/2013
	 * @version 1.0
	 * @see
	 */
	public class ResPool {
		
		/**
		 * 本类实例
		 */
		private static var _instance:ResPool;
		
		private var map:Dictionary;
		
		/**
		 * Constructor
		 */
		public function ResPool(singleton:Singleton) {
			map = new Dictionary(true);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function getObject(key:String):Object {
			var obj:Object = map[key];
			return obj ? obj : null;
		}
		
		public function putObject(key:String, val:Object):void {
			map[key] = val;
		}
		
		public function getBmdFromSwf(className:String, swf:SWFLoader, put:Boolean = true):BitmapData {
			var bmd:BitmapData = getObject(className) as BitmapData;
			if (bmd) return bmd;
			var c:Class = swf.getClass(className);
			bmd = c ? new c() : null;
			if (bmd) {
				if (put) this.putObject(className, bmd);
			}
			return bmd;
		}
		
		public static function get instance():ResPool {
			return _instance ||= new ResPool(new Singleton);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}
	
}
final class Singleton{}