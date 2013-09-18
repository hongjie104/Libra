package org.libra.ui.flash.core.state.ctrl {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import org.libra.utils.asset.AssetsStorage;
	import org.libra.utils.displayObject.BitmapDataUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseCheckBoxStateCtrl
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/26/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseCheckBoxStateCtrl extends BaseButtonStateCtrl {
		
		protected var $normalSelectedBmd:BitmapData;
		
		protected var $overSelectedBmd:BitmapData;
		
		protected var $downSelectedBmd:BitmapData;
		
		public function BaseCheckBoxStateCtrl(loader:Loader) {
			super(loader);
		}
		
		public function get normalSelectedBmd():BitmapData {
			return $normalSelectedBmd;
		}
		
		public function get overSelectedBmd():BitmapData {
			return $overSelectedBmd;
		}
		
		public function get downSelectedBmd():BitmapData {
			return $downSelectedBmd;
		}
		
		override public function set skin(val:String):void {
			this.$skin = val;
			const source:BitmapData = AssetsStorage.getInstance().getBitmapData($skin, $loader, false);
			const bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width >> 1, source.height / 3, source);
			$normalBmd = bmdList[0][0];
			$overBmd = bmdList[1][0];
			$downBmd = bmdList[2][0];
			$normalSelectedBmd = bmdList[0][1];
			$overSelectedBmd = bmdList[1][1];
			$downSelectedBmd = bmdList[2][1];
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}