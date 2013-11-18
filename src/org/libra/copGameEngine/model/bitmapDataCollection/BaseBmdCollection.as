package org.libra.copGameEngine.model.bitmapDataCollection {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	import org.libra.utils.asset.IAsset;
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
	public class BaseBmdCollection implements IAsset {
		
		protected var _url:String;
		
		protected var _bitmapData:BitmapData;
		
		protected var _loaded:Boolean;
		
		protected var _id:String;
		
		public function BaseBmdCollection(id:String) {
			_id = id;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection */
		
		public function get url():String {
			return _url;
		}
		
		public function get bitmapData():BitmapData {
			return _bitmapData;
		}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		public function doSthAfterLoad(swfLoader:SWFLoader):void {
			const c:Class = swfLoader.getClass(_id);
			_bitmapData = c ? new c() : null;
			_loaded = true;
		}
		
		/* INTERFACE org.libra.copGameEngine.model.bitmapDataCollection.IBmdCollection */
		
		public function get id():String {
			return _id;
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