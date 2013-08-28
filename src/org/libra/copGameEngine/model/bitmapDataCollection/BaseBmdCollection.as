package org.libra.copGameEngine.model.bitmapDataCollection {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseBmdCollection
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/28/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseBmdCollection implements IBmdCollection {
		
		protected var $url:String;
		
		protected var $bitmapData:BitmapData;
		
		protected var $loaded:Boolean;
		
		protected var $bmdClass:String;
		
		public function BaseBmdCollection(bmdClass:String) {
			$bmdClass = bmdClass;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection */
		
		public function get url():String {
			return $url;
		}
		
		public function get bitmapData():BitmapData {
			return $bitmapData;
		}
		
		public function get loaded():Boolean {
			return $loaded;
		}
		
		public function doSthAfterLoad(swfLoader:SWFLoader):void {
			const c:Class = swfLoader.getClass($bmdClass);
			$bitmapData = c ? new c() : null;
			$loaded = true;
		}
		
		public function get bmdClass():String {
			return $bmdClass;
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}