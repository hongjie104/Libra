package org.libra.copGameEngine.component {
	import flash.display.BitmapData;
	import org.libra.copGameEngine.entity.IEntityComponent;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class IBitmapDataComponent
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/22/2013
	 * @version 1.0
	 * @see
	 */
	public interface IBitmapDataRender extends IEntityComponent {
		
		function set bitmapData(bmd:BitmapData):void;
		
	}
	
}