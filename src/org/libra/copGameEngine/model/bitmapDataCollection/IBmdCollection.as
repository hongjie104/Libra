package org.libra.copGameEngine.model.bitmapDataCollection {
	import com.greensock.loading.SWFLoader;
	import flash.display.BitmapData;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IBmdCollection
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public interface IBmdCollection {
		
		function get bmdClass():String;
		
		function get url():String;
		
		function get bitmapData():BitmapData;
		
		function get loaded():Boolean;
		
		function doSthAfterLoad(swfLoader:SWFLoader):void;
		
	}
	
}