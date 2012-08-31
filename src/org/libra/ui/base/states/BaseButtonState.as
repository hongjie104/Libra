package org.libra.ui.base.states {
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
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
	public final class BaseButtonState extends Bitmap implements IState {
		
		private var getBmd:Function;
		
		private var resName:String;
		
		public function BaseButtonState() {
			super();
			getBmd = ResManager.getInstance().getBitmapData;
		}
		
		/*-----------------------------------------------------------------------------------------
		Public methods
		-------------------------------------------------------------------------------------------*/
		
		/* INTERFACE org.libra.ui.base.states.IState */
		
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
		
		public function toMouseOut():void {
			toNormal();
		}
		
		public function toMouseDown():void {
			this.bitmapData = getBmd(resName + '_down');
		}
		
		public function toMouseUp():void {
			toMouseOver();
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