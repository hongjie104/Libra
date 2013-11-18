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
	 * @class BaseButtonStateCtrl
	 * @author 鸿杰
	 * @qq 32968210
	 * @date 08/26/2013
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonStateCtrl {
		
		protected var _skin:String;
		
		protected var _normalBmd:BitmapData;
		
		protected var _overBmd:BitmapData;
		
		protected var _downBmd:BitmapData;
		
		protected var _loader:Loader;
		
		public function BaseButtonStateCtrl(loader:Loader) {
			_loader = loader;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		public function get normalBmd():BitmapData {
			return _normalBmd;
		}
		
		public function get overBmd():BitmapData {
			return _overBmd;
		}
		
		public function get downBmd():BitmapData {
			return _downBmd;
		}
		
		public function set skin(val:String):void {
			this._skin = val;
			const source:BitmapData = AssetsStorage.instance.getBitmapData(_skin, _loader, false);
			const bmdList:Vector.<Vector.<BitmapData>> = BitmapDataUtil.separateBitmapData(source.width, source.height / 3, source);
			_normalBmd = bmdList[0][0];
			_overBmd = bmdList[1][0];
			_downBmd = bmdList[2][0];
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}