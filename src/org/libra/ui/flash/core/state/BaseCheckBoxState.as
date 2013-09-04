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
		
		protected var $selected:Boolean;
		
		protected var $checkBoxStateCtrl:BaseCheckBoxStateCtrl;
		
		public function BaseCheckBoxState(loader:Loader) {
			super(loader);
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		override public function toNormal():void {
			this.bitmapData = $selected ? $checkBoxStateCtrl.normalSelectedBmd : $checkBoxStateCtrl.normalBmd;
		}
		
		override public function toMouseOver():void {
			this.bitmapData = $selected ? $checkBoxStateCtrl.overSelectedBmd : $checkBoxStateCtrl.overBmd;
		}
		
		override public function toMouseDown():void {
			this.bitmapData = $selected ? $checkBoxStateCtrl.downSelectedBmd : $checkBoxStateCtrl.downBmd;
		}
		
		/* INTERFACE org.libra.ui.base.stateus.interfaces.ISelectStatus */
		
		public function set selected(val:Boolean):void {
			$selected = val;
		}
		
		override public function set resName(value:String):void {
			this.$resName = value;
			$checkBoxStateCtrl = AssetsStorage.getInstance().getObj(value) as BaseCheckBoxStateCtrl;
			if (!$checkBoxStateCtrl) {
				$checkBoxStateCtrl = new BaseCheckBoxStateCtrl($loader);
				$checkBoxStateCtrl.resName = value;
				AssetsStorage.getInstance().putObj(value, $checkBoxStateCtrl);
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