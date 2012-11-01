package org.libra.ui.flash.core.stateus {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import org.libra.ui.base.stateus.interfaces.IButtonStatus;
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
	public class BaseButtonStatus extends Bitmap implements IButtonStatus {
		
		protected var getBmd:Function;
		
		protected var resName:String;
		
		public function BaseButtonStatus() {
			super();
			getBmd = ResManager.getInstance().getBitmapData;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IStatus */
		
		public function setResName(val:String):void {
			this.resName = val;
		}
		
		public function setSize(w:int, h:int):void {
			//this.$width = w;
			//this.$height = h;
		}
		
		public function getDisplayObject():DisplayObject {
			return this;
		}
		
		public function toNormal():void {
			this.bitmapData = getBmd(resName + '_normal');
		}
		
		public function toMouseOver():void {
			this.bitmapData = getBmd(resName + '_over');
		}
		
		//public function toMouseOut():void {
			//toNormal();
		//}
		
		public function toMouseDown():void {
			this.bitmapData = getBmd(resName + '_down');
		}
		
		//public function toMouseUp():void {
			//toMouseOver();
		//}
		
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