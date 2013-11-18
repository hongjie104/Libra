package org.libra.ui.flash.core.state {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import org.libra.ui.flash.core.state.ctrl.BaseButtonStateCtrl;
	import org.libra.utils.asset.AssetsStorage;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseButtonState
	 * @author Eddie
	 * @qq 32968210
	 * @date 08-31-2012
	 * @version 1.0
	 * @see
	 */
	public class BaseButtonState extends Bitmap implements IButtonState {
		
		protected var _getBmd:Function;
		
		protected var _skin:String;
		
		protected var _actualWidth:int;
		
		protected var _actualHeight:int;
		
		protected var _btnStatsCtrl:BaseButtonStateCtrl;
		
		protected var _loader:Loader;
		
		public function BaseButtonState(loader:Loader) {
			super();
			_loader = loader;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IStatus */
		
		public function set skin(val:String):void {
			this._skin = val;
			_btnStatsCtrl = AssetsStorage.instance.getObj(val) as BaseButtonStateCtrl;
			if (!_btnStatsCtrl) {
				_btnStatsCtrl = new BaseButtonStateCtrl(_loader);
				_btnStatsCtrl.skin = val;
				AssetsStorage.instance.putObj(val, _btnStatsCtrl);
			}
			toNormal();
		}
		
		public function setSize(w:int, h:int):void {
			_actualWidth = w;
			_actualHeight = h;
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			this.bitmapData = _btnStatsCtrl.normalBmd;
		}
		
		public function toMouseOver():void {
			this.bitmapData = _btnStatsCtrl.overBmd;
		}
		
		public function toMouseDown():void {
			this.bitmapData = _btnStatsCtrl.downBmd;
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