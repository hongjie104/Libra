package org.libra.ui.flash.core.state {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import org.libra.ui.flash.core.state.ctrl.BaseButtonStateCtrl;
	import org.libra.ui.utils.ResManager;
	
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
		
		protected var $resName:String;
		
		protected var $actualWidth:int;
		
		protected var $actualHeight:int;
		
		protected var btnStatsCtrl:BaseButtonStateCtrl;
		
		public function BaseButtonState() {
			super();
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IStatus */
		
		public function set resName(val:String):void {
			this.$resName = val;
			btnStatsCtrl = ResManager.getInstance().getObj(val) as BaseButtonStateCtrl;
			if (!btnStatsCtrl) {
				btnStatsCtrl = new BaseButtonStateCtrl();
				btnStatsCtrl.resName = val;
				ResManager.getInstance().putObj(val, btnStatsCtrl);
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
			this.bitmapData = btnStatsCtrl.normalBmd;
		}
		
		public function toMouseOver():void {
			this.bitmapData = btnStatsCtrl.overBmd;
		}
		
		public function toMouseDown():void {
			this.bitmapData = btnStatsCtrl.downBmd;
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