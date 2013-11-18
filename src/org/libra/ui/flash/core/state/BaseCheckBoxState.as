package org.libra.ui.flash.core.state {
	import flash.display.Loader;
	import org.libra.ui.flash.core.state.ctrl.BaseCheckBoxStateCtrl;
	import org.libra.utils.asset.AssetsStorage;
	
	/**
	 * <p>
	 * Description
	 * </p>
	 *
	 * @class BaseCheckBoxState
	 * @author Eddie
	 * @qq 32968210
	 * @date 09/01/2012
	 * @version 1.0
	 * @see
	 */
	public class BaseCheckBoxState extends BaseButtonState implements ISelectState {
		
		protected var _selected:Boolean;
		
		protected var _checkBoxStateCtrl:BaseCheckBoxStateCtrl;
		
		public function BaseCheckBoxState(loader:Loader) {
			super(loader);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toNormal():void {
			this.bitmapData = _selected ? _checkBoxStateCtrl.normalSelectedBmd : _checkBoxStateCtrl.normalBmd;
		}
		
		override public function toMouseOver():void {
			this.bitmapData = _selected ? _checkBoxStateCtrl.overSelectedBmd : _checkBoxStateCtrl.overBmd;
		}
		
		override public function toMouseDown():void {
			this.bitmapData = _selected ? _checkBoxStateCtrl.downSelectedBmd : _checkBoxStateCtrl.downBmd;
		}
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function set selected(val:Boolean):void {
			_selected = val;
		}
		
		override public function set skin(value:String):void {
			this._skin = value;
			_checkBoxStateCtrl = AssetsStorage.instance.getObj(value) as BaseCheckBoxStateCtrl;
			if (!_checkBoxStateCtrl) {
				_checkBoxStateCtrl = new BaseCheckBoxStateCtrl(_loader);
				_checkBoxStateCtrl.skin = value;
				AssetsStorage.instance.putObj(value, _checkBoxStateCtrl);
			}
			toNormal();
		}
		
		/*-----------------------------------------------------------------------------------------
		Private methods
		-------------------------------------------------------------------------------------------*/
		
		/*-----------------------------------------------------------------------------------------
		Event Handlers
		-------------------------------------------------------------------------------------------*/
		
	}

}