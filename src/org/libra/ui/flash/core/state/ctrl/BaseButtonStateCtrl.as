package org.libra.ui.flash.core.state.ctrl {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import org.libra.ui.utils.ResManager;
	import org.libra.utils.displayObject.BitmapDataUtil;
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseButtonStateCtrl
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/26/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonStateCtrl {
		
		protected var $resName:String;
		
		protected var $normalBmd:BitmapData;
		
		protected var $overBmd:BitmapData;
		
		protected var $downBmd:BitmapData;
		
		protected var $loader:Loader;
		
		public function BaseButtonStateCtrl(loader:Loader) {
			$loader = loader;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get normalBmd():BitmapData {
			return $normalBmd;
		}
		
		public function get overBmd():BitmapData {
			return $overBmd;
		}
		
		public function get downBmd():BitmapData {
			return $downBmd;
		}
		
		public function set resName(resName:String):void {
			this.$resName = resName;
			const source:BitmapData = ResManager.getInstance().getBitmapData(resName, $loader, false);
			const bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width, source.height / 3, source);
			$normalBmd = bmdList[0][0];
			$overBmd = bmdList[1][0];
			$downBmd = bmdList[2][0];
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}