package org.libra.ui.flash.components {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import org.libra.ui.flash.core.Component;
	import org.libra.ui.invalidation.InvalidationFlag;
	
	/**
	 * <p>
	 * 图像
	 * </p>
	 *
	 * @class JImage
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 05/17/2013
	 * @version 1.0
	 * @see
	 */
	public class JImage extends Component {
		
		protected var $bitmap:Bitmap;
		
		protected var $bitmapData:BitmapData;
		
		public function JImage(bitmapData:BitmapData = null, x:int = 0, y:int = 0) { 
			super(x, y);
			$bitmap = new Bitmap(bitmapData);
			addChild($bitmap);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get bitmapData():BitmapData {
			return $bitmapData;
		}
		
		public function set bitmapData(val:BitmapData):void {
			$bitmapData = val;
			this.invalidate(InvalidationFlag.DATA);
		}
		
		override public function clone():Component {
			return new JImage($bitmapData, x, y);
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		override protected function refreshData():void {
			$bitmap.bitmapData = $bitmapData;
		}
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}