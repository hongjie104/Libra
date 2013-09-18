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
		
		protected var $getBmd:Function;
		
		protected var $skin:String;
		
		protected var $actualWidth:int;
		
		protected var $actualHeight:int;
		
		protected var $btnStatsCtrl:BaseButtonStateCtrl;
		
		protected var $loader:Loader;
		
		public function BaseButtonState(loader:Loader) {
			super();
			$loader = loader;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IStatus */
		
		public function set skin(val:String):void {
			this.$skin = val;
			$btnStatsCtrl = AssetsStorage.getInstance().getObj(val) as BaseButtonStateCtrl;
			if (!$btnStatsCtrl) {
				$btnStatsCtrl = new BaseButtonStateCtrl($loader);
				$btnStatsCtrl.skin = val;
				AssetsStorage.getInstance().putObj(val, $btnStatsCtrl);
			}
			toNormal();
		}
		
		public function setSize(w:int, h:int):void {
			$actualWidth = w;
			$actualHeight = h;
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			this.bitmapData = $btnStatsCtrl.normalBmd;
		}
		
		public function toMouseOver():void {
			this.bitmapData = $btnStatsCtrl.overBmd;
		}
		
		public function toMouseDown():void {
			this.bitmapData = $btnStatsCtrl.downBmd;
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