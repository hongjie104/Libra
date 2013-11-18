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
		
		protected var _normalSelectedBmd:BitmapData;
		
		protected var _overSelectedBmd:BitmapData;
		
		protected var _downSelectedBmd:BitmapData;
		
		public function BaseCheckBoxStateCtrl(loader:Loader) {
			super(loader);
		}
		
		public function get normalSelectedBmd():BitmapData {
			return _normalSelectedBmd;
		}
		
		public function get overSelectedBmd():BitmapData {
			return _overSelectedBmd;
		}
		
		public function get downSelectedBmd():BitmapData {
			return _downSelectedBmd;
		}
		
		override public function set skin(val:String):void {
			this._skin = val;
			const source:BitmapData = AssetsStorage.instance.getBitmapData(_skin, _loader, false);
			const bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width >> 1, source.height / 3, source);
			_normalBmd = bmdList[0][0];
			_overBmd = bmdList[1][0];
			_downBmd = bmdList[2][0];
			_normalSelectedBmd = bmdList[0][1];
			_overSelectedBmd = bmdList[1][1];
			_downSelectedBmd = bmdList[2][1];
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