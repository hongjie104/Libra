package org.libra.copGameEngine.model.bitmapDataCollection {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	import flash.events.Event;
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
		
		protected var $id:String;
		
		public function BaseBmdCollection(id:String) {
			$id = id;
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
			const c:Class = swfLoader.getClass($id);
			$bitmapData = c ? new c() : null;
			$loaded = true;
		}
		
		/* INTERFACE org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection */
		
		public function get id():String {
			return $id;
		}
		
		public function dispose():void {
			
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}